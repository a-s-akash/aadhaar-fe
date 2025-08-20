import 'dart:developer';
import 'dart:math' as math;

import 'package:aadhaar_flutter/pages/Create_Edit/Core_Details_Page/core_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Show_Details_Page/show_details_screen.dart';
import 'package:aadhaar_flutter/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final contactDetailsController = ChangeNotifierProvider<ContactDetailsProvider>(
    (ref) => ContactDetailsProvider());
final TextEditingController _mobileNumTextController = TextEditingController();
final TextEditingController _mobileOTPTextController = TextEditingController();
final TextEditingController _mailIdTextController = TextEditingController();
final TextEditingController _mailOTPTextController = TextEditingController();

class ContactDetailsProvider extends ChangeNotifier {
  Map<String, dynamic> _data = {};
  bool _isMobileVerified = false;
  bool _isMailVerified = false;
  bool _showMobileOTPField = false;
  bool _showMailOTPField = false;
  bool _showgetOTPMobile = true;
  bool _showgetOTPMail = true;
  bool _showQR = false;
  String _qrData = '';
  String _expectedOtp = '';
  String _expectedMailOtp = '';

  void onMobileChanged(String value) {
    _showgetOTPMobile = true;
    if (_isMobileVerified || _showMobileOTPField) {
      _isMobileVerified = false;
      _showMobileOTPField = false;
      _showQR = false;
      _qrData = "";
      _expectedOtp = "";
    }
    notifyListeners();
  }

  void onMailChanged(String value) {
    _showgetOTPMail = true;
    if (_isMailVerified || _showMailOTPField) {
      _isMailVerified = false;
      _showMailOTPField = false;
    }
    notifyListeners();
  }

  Future<void> getMobileOtp(ref) async {
    if (ref.watch(regNumController).isEdit) {
      await ref.read(regNumController).editedUpdate("Contact Details");
    }
    try {
      final response = await Dio().post(
        OTP_API,
        data: {
          "secretKey": OTP_SECRET_KEY,
          "phoneNumber": _mobileNumTextController.text,
        },
      );
      _qrData = response.data['data']['qrData']['alphabetData'] ?? "";
      _expectedOtp = response.data['data']['otp'] ?? "";
      if (_qrData.isNotEmpty) {
        _showQR = true;
        _showMobileOTPField = true;
        _mobileOTPTextController.clear();
      }
    } catch (e) {
      log("Error: $e");
    }
    // _expectedOtp = "123456";
    notifyListeners();
  }

  void getMailOtp(ref) async {
    if (ref.watch(regNumController).isEdit) {
      await ref.read(regNumController).editedUpdate("Contact Details");
    }
    try {
      final response = await Dio().post(
        '$baseURL/mail/send',
        data: {
          "toId": _mailIdTextController.text,
        },
      );
      if (response.statusCode == 200) {
        _showMailOTPField = true;
        _mailOTPTextController.clear();
        _expectedMailOtp = response.data['OTP'];
      } else {
        _showMailOTPField = false;
        EasyLoading.showInfo("Please retry!");
      }
    } catch (e) {
      _showMailOTPField = false;
      EasyLoading.showInfo("Please retry!");
      log("Error: $e");
    }
    // _expectedMailOtp = '123456';

    notifyListeners();
  }

  void validateMobileOtp() {
    if (mobileOTPTextController.text == _expectedOtp) {
      _isMobileVerified = true;
      _showMobileOTPField = false;
      _showQR = false;
      _qrData = "";
      notifyListeners();
    }
  }

  void validateMailOtp() {
    if (mailOTPTextController.text == _expectedMailOtp) {
      _isMailVerified = true;
      _showMailOTPField = false;
      notifyListeners();
    }
  }

  sendData(context, ref) async {
    _data = {
      'mobile': _mobileNumTextController.text,
      'email': _mailIdTextController.text,
    };
    notifyListeners();
    EasyLoading.dismiss();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowDetailsScreen(),
        ));
  }

  valueUpdate(ref) async {
    notifyListeners();
    if (ref.watch(regNumController).isEdit) {
      await ref.read(regNumController).editedUpdate("Contact Details");
    }
  }

  clearText() {
    _mobileNumTextController.clear();
    _mailIdTextController.clear();
    _mobileOTPTextController.clear();
    _mailOTPTextController.clear();
    _isMobileVerified = false;
    _isMailVerified = false;
    _showMobileOTPField = false;
    _showMailOTPField = false;
    notifyListeners();
  }

  editValueUpdate(val) {
    _mobileNumTextController.text = val['mobile'] ?? '';
    _mailIdTextController.text = val['email'] ?? '';
    _showgetOTPMail = false;
    _showgetOTPMobile = false;
    _isMailVerified = true;
    _isMobileVerified = true;
    notifyListeners();
  }

  TextEditingController get mobileNumTextController => _mobileNumTextController;
  TextEditingController get mailIdTextController => _mailIdTextController;
  TextEditingController get mobileOTPTextController => _mobileOTPTextController;
  TextEditingController get mailOTPTextController => _mailOTPTextController;
  String get qrData => _qrData;
  bool get isMobileVerified => _isMobileVerified;
  bool get isMailVerified => _isMailVerified;
  bool get showMobileOTPField => _showMobileOTPField;
  bool get showMailOTPField => _showMailOTPField;
  bool get showgetOTPMobile => _showgetOTPMobile;
  bool get showgetOTPMail => _showgetOTPMail;
  Map<String, dynamic> get data => _data;
  bool get showQR => _showQR;
  String get expectedOtp => _expectedOtp;
  String get expectedmailOtp => _expectedMailOtp;
}
