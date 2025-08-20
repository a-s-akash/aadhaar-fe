import 'dart:developer';

import 'package:aadhaar_flutter/pages/Authentication/Login_Page/login_controller.dart';
import 'package:aadhaar_flutter/pages/Authentication/Login_Page/login_screen.dart';
import 'package:aadhaar_flutter/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupController =
    ChangeNotifierProvider<SignupProvider>((ref) => SignupProvider());
final TextEditingController _nameTextController = TextEditingController();
final TextEditingController _userNameTextController = TextEditingController();
final TextEditingController _pwdTextController = TextEditingController();
final TextEditingController _rePwdTextController = TextEditingController();
final TextEditingController _accNameTextController = TextEditingController();
final TextEditingController _accNumTextController = TextEditingController();

class SignupProvider extends ChangeNotifier {
  bool _passwordVisible = true;

  passwordVisibleChange() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  createUser(context, ref) async {
    if (_pwdTextController.text != _rePwdTextController.text) {
      EasyLoading.showError("Password doesn't match");
    } else {
      try {
        Response response = await Dio().post(
          '$baseURL/signup/',
          data: {
            'username': _userNameTextController.text,
            'password': _pwdTextController.text,
            'fullName': _nameTextController.text,
            'accName': _accNameTextController.text,
            'accNo': _accNumTextController.text,
          },
          options: Options(
            validateStatus: (status) => true,
          ),
        );
        if (response.statusCode == 200) {
          EasyLoading.showSuccess('Account Created Successfully');
          ref.read(loginController).clearText();
          await Future.delayed(Duration(seconds: 2));
          clearText();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        } else {
          EasyLoading.dismiss();

          if (response.statusCode == 409) {
            EasyLoading.showError('Username Already Taken');
          } else {
            EasyLoading.showError('Signup Failed');
          }
        }
      } catch (e) {
        log(e.toString());
        EasyLoading.dismiss();
        EasyLoading.showError('Signup Failed');
      }
    }
  }

  valueUpdate() {
    notifyListeners();
  }

  clearText() {
    _nameTextController.clear();
    _userNameTextController.clear();
    _pwdTextController.clear();
    _rePwdTextController.clear();
    _accNameTextController.clear();
    _accNumTextController.clear();
    notifyListeners();
  }

  TextEditingController get nameTextController => _nameTextController;
  TextEditingController get userNameTextController => _userNameTextController;
  TextEditingController get pwdTextController => _pwdTextController;
  TextEditingController get rePwdTextController => _rePwdTextController;
  TextEditingController get accNameTextController => _accNameTextController;
  TextEditingController get accNumTextController => _accNumTextController;
  bool get passwordVisible => _passwordVisible;
}
