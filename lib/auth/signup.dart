import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_video_call/auth/login.dart';
import 'package:flutter_video_call/components/password_field.dart';
import 'package:flutter_video_call/components/text_form_builder.dart';
import 'package:flutter_video_call/utils/validations.dart';
import 'package:flutter_video_call/view_models/auth/registerVM.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(),
      inAsyncCall: viewModel.loading,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          children: [
            SizedBox(height: 70.0),
            Icon(
              CupertinoIcons.videocam_circle_fill,
              color: Theme.of(context).accentColor,
              size: 100.0,
            ),
            SizedBox(height: 50.0),
            buildForm(context, viewModel),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? '),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (_) => Login(),
                      ),
                    );
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildForm(BuildContext context, RegisterViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Feather.user,
            hintText: "Username",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setName(val);
            },
            focusNode: viewModel.usernameFN,
            nextFocusNode: viewModel.emailFN,
          ),
          SizedBox(height: 15.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Feather.mail,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.passFN,
          ),
          SizedBox(height: 15.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Feather.lock,
            suffix: Feather.eye,
            hintText: "Password",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validatePassword,
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passFN,
            nextFocusNode: viewModel.cPassFN,
          ),
          SizedBox(height: 15.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Feather.lock,
            hintText: "Confirm Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            submitAction: () => viewModel.register(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setConfirmPass(val);
            },
            focusNode: viewModel.cPassFN,
          ),
          SizedBox(height: 20.0),
          Container(
            height: 45.0,
            width: 180.0,
            child: RaisedButton(
              highlightElevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              color: Theme.of(context).accentColor,
              child: Text(
                'sign up'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => viewModel.register(context),
            ),
          ),
        ],
      ),
    );
  }
}
