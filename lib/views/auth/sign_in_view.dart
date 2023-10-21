// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../constants/app_string.dart';
import '../../constants/colors.dart';

import '../../controllers/auth/sign_in_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _signinController = Get.put(SigninController());

  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  final _loginkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _loginkey,
            child: ListView(
              children: [
                _image(),
                SizedBox(height: 20),
                _title(),
                SizedBox(height: 20),
                _userName(),
                SizedBox(height: 20),
                _password(),
                SizedBox(height: 10),
                _logIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logIn() {
    return Obx(() {
      final controller = Get.find<SigninController>();
      return Material(
        color: kBaseColor,
        borderRadius: BorderRadius.circular(controller.changedButton.value ? 50 : 8),
        child: InkWell(
          onTap: () {
            if (_loginkey.currentState!.validate()) {
              controller.handleLogin();
            }
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: controller.changedButton.value ? 50 : 150,
            height: 50,
            alignment: Alignment.center,
            child: controller.changedButton.value
                ? Icon(
                    Icons.done,
                    color: Colors.white,
                  )
                : Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
          ),
        ),
      );
    });
  }

  // MaterialButton(
  //     animationDuration: Duration(seconds: 5),
  //     elevation: 0,
  //     height: 35,
  //     minWidth: 160,
  //     onPressed: () {
  //       Get.to(() => HomePage());
  //     },
  //     color: kBaseColor,
  //     child: Text(
  //       "Login",
  //       style: TextStyle(fontSize: 14, color: Colors.white),
  //     ),
  //   );
  // }

  Widget _password() {
    return Obx(() {
      final controller = Get.find<SigninController>();
      return TextFormField(
        obscureText: controller.hidePassword.value,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(color: kBaseColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kBaseColor, width: 2),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: kBaseColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              controller.hidePassword.value = !controller.hidePassword.value;
            },
            icon: controller.hidePassword.value
                ? Icon(Icons.visibility)
                : Icon(
                    Icons.visibility_off,
                  ),
          ),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        ),
        controller: _passwordController,
        validator: MultiValidator([
          RequiredValidator(errorText: "Password is required"),
          MinLengthValidator(6, errorText: "Password should be at least 6 characters"),
        ]),
      );
    });
  }

  Widget _userName() {
    final controller = Get.find<SigninController>();
    return TextFormField(
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        labelText: "User Name / Email",
        labelStyle: TextStyle(color: kBaseColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBaseColor, width: 2),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: kBaseColor,
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      ),
      onChanged: (value) {
        controller.name.value = value;
      },
      controller: _userNameController,
      validator: MultiValidator([
        RequiredValidator(errorText: "User Name/Email is required"),
        MinLengthValidator(3, errorText: "At least 3 characters"),
        EmailValidator(errorText: "Enter a valid Email"),
      ]),
    );
  }

  Widget _title() {
    return Obx(() {
      final controller = Get.find<SigninController>();
      return Center(
        child: Text(
          "Welcome ${controller.name.value}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    });
  }

  Widget _image() {
    return Image.asset(
      SIGN_IN_IMAGE,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
