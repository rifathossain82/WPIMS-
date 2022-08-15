import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wpims/pages/home/view/home.dart';
import 'package:wpims/pages/login/controller/auth_controller.dart';
import 'package:wpims/pages/login/model/login.dart';
import 'package:wpims/pages/otp/view/otp.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/constants/labels.dart';
import 'package:wpims/utils/snackbars.dart';
import 'package:wpims/utils/widgets/buttons.dart';
import 'package:wpims/utils/widgets/helper.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool btnLoading = false;
  void requestLogin()async{
    final response=await ApiService().post('student-login', {
      'studentId': idController.text,
      'password': passwordController.text,
    });
    if(response.statusCode==200) {
      LoginResponseModel loginResponse = loginResponseFromJson(response.body);
        setState(() {
          btnLoading=false;
        });
        ShowSuccessMsg(context: context, message: 'Login Was Successful',duration: 2);
        Get.to(Otp(userId:idController.text));
    }else{
      setState(() {
        btnLoading=false;
      });
      var errors=loginErrorFromJson(response.body);
      ShowWarningMsg(context: context,message:errors.message);
      ShowWarningMsg(context: context,message:errors.message);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset:false,
      body: Center(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              // autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: textLight, width: 4),
                    ),
                    child: Image.asset('assets/images/logo.png', width: 150),
                  ),
                  addVerticalSpace(32),
                  _buildFormEmail(hint: 'Userid'),
                  addVerticalSpace(16),
                  _buildFormPassword(hint: 'Password'),
                  addVerticalSpace(48),
                  _buildLoginButton(),
                  addVerticalSpace(16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormEmail({required String hint}) {
    return Stack(children: [
      Container(
        decoration:
            boxDecoration(radius: 40, showShadow: true, bgColor: bgLight),
        height: 55,
      ),
      TextFormField(
        controller: idController,
        decoration: InputDecoration(
          hintText: hint,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid email';
          }
          return null;
        },
        onSaved: (String? value) {
          // setState(() {
          //   _formEmail = value;
          // });
        },
      ),
    ]);
  }

  Widget _buildFormPassword({required String hint}) {
    return Stack(
      children: [
        Container(
          decoration:
              boxDecoration(radius: 40, showShadow: true, bgColor: bgLight),
          height: 55,
        ),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: hint,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid password';
            }
            return null;
          },
          // onSaved: (String? value) {
          //   setState(() {
          //     _formEmail = value;
          //   });
          // },
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      alignment: Alignment.center,
      child: submitButton(
        btnLoading: btnLoading,
        label: loginLabel,
        onPressed: () {
          // _formKey.currentState!.validate();
          if (_formKey.currentState!.validate()) {
            FocusScope.of(context).requestFocus(FocusNode());

            setState(() {
              btnLoading = true;
            });
            requestLogin();
          }
        },
      ),
    );
  }
}
