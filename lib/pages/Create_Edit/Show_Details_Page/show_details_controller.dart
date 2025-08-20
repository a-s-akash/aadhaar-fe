import 'dart:convert';
import 'dart:developer';

import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Address_Details_Page/addr_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Contact_Details_Page/contact_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Core_Details_Page/core_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Educational_Details_Page/edu_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:aadhaar_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:html' as html;

import 'package:shared_preferences/shared_preferences.dart';

final showDetailsController =
    ChangeNotifierProvider<ShowDetailsProvider>((ref) => ShowDetailsProvider());

class ShowDetailsProvider extends ChangeNotifier {
  setSendData(ref) async {
    bool isEdit = ref.watch(regNumController).isEdit;

    final allData = {
      'isEdit': isEdit,
      'regNumber': ref.watch(regNumController).regNumTextController.text,
      'nameDetails': await ref.read(coreDetailsController).data,
      'addressDetails': await ref.read(addrDetailsController).data,
      'educationDetails': await ref.read(eduDetailsController).data,
      'photoDetails': await ref.read(liveCamController).data,
      'contactDetails': await ref.read(contactDetailsController).data,
      'editDetails':
          isEdit ? ref.watch(regNumController).edited.toList() : "Register"
    };
    log(ref.read(coreDetailsController).data.toString());
    log(ref.read(addrDetailsController).data.toString());
    log(ref.read(eduDetailsController).data.toString());
    log(ref.read(contactDetailsController).data.toString());
    html.window.localStorage['sendData'] = jsonEncode(allData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imageData', ref.watch(liveCamController).base64Json);
  }

  pay(context, ref) async {
    bool isEdit = ref.watch(regNumController).isEdit;
    try {
      String amount = isEdit ? '50' : '100';
      final payload = {
        'email': 'admin@aadhaar.com',
        'code': 'suhaina@paygate',
        'amount': double.parse(amount),
      };

      final jsonStringForPayment = jsonEncode(payload);
      final base64 = base64Encode(utf8.encode(jsonStringForPayment));
      final encoded = Uri.encodeComponent(base64);
      final encodedReturnURL = Uri.encodeComponent("http://localhost:56789/");
      html.window.location.href =
          "$PAYMENT_API/payment/$encoded?returnUrl=$encodedReturnURL";
    } catch (e) {
      log("Error: $e");
      EasyLoading.showError('Failed Retry!');
    }
    notifyListeners();
  }
}
