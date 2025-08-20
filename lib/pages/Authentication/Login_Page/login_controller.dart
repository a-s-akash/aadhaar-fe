import 'dart:developer';
import 'dart:html' as html;
import 'package:aadhaar_flutter/pages/Home_Page/home_screen.dart';
import 'package:aadhaar_flutter/pages/Authentication/Login_Page/login_screen.dart';
import 'package:aadhaar_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final loginController =
    ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());
final TextEditingController _userNameTextController = TextEditingController();
final TextEditingController _pwdTextController = TextEditingController();

class LoginProvider extends ChangeNotifier {
  bool _passwordVisible = true;
  String _userName = '';

  passwordVisibleChange() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  logout(context, ref) async {
    html.window.localStorage.remove('username');
    clearText();
    EasyLoading.showSuccess('Logout Successful');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  authenticateUser(context, ref) async {
    try {
      Response response = await Dio().post(
        '$baseURL/login/',
        data: {
          'username': _userNameTextController.text,
          'password': _pwdTextController.text
        },
      );
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Login Successful');
        html.window.localStorage['username'] = _userNameTextController.text;
        _userName = _userNameTextController.text;
        clearText();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        log(response.data);
        EasyLoading.dismiss();
        EasyLoading.showError('Login Failed');
      }
    } catch (e) {
      log(e.toString());
      EasyLoading.dismiss();
      EasyLoading.showError('Login Failed');
    }
    notifyListeners();
  }

  valueUpdate() {
    notifyListeners();
  }

  clearText() {
    _userNameTextController.text = '';
    _pwdTextController.text = '';
    _passwordVisible = true;
    notifyListeners();
  }

  TextEditingController get userNameTextController => _userNameTextController;
  TextEditingController get pwdTextController => _pwdTextController;
  bool get passwordVisible => _passwordVisible;
  String get userName => _userName;
}
