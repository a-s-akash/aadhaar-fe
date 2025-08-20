import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;

import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Final_Page/final_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Final_Page/final_screen.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:aadhaar_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final paymentController =
    ChangeNotifierProvider<PaymentProvider>((ref) => PaymentProvider());
final TextEditingController _uniqueIDTextController = TextEditingController();

class PaymentProvider extends ChangeNotifier {
  rePayment(context, ref) {
    String? jsonString = html.window.localStorage['sendData'];
    if (jsonString != null) {
      Map<String, dynamic> data = jsonDecode(jsonString);
      String amount = data['isEdit'] ? '50' : '100';
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
      // html.window.location.href =
      //     "https://payment-gateway-frontend-chi.vercel.app/payment/akash@paygate/$amount?returnUrl=http://localhost:56789/";
    }
  }

  sendData(context, ref, [txId = '']) async {
    final jsonString = html.window.localStorage['sendData'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final imageData = prefs.getString('imageData');
    final Map<String, dynamic> data = jsonDecode(jsonString!);
    log(data.toString());
    String regNum = data['regNumber'];
    bool isEdit = data['isEdit'];
    late Response response;
    try {
      if (!isEdit) {
        response = await Dio().post(
          STUDENT_API,
          data: {
            "regNumber": regNum,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
      } else {
        response = await Dio().post(
          '$STUDENT_API/check',
          data: {
            "regNumber": regNum,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
      }

      if (response.statusCode == 200) {
        response = await Dio().post(
          '$STUDENT_API/name',
          data: {'regNumber': regNum, 'nameDetails': data['nameDetails']},
        );
        log("regnum updated");

        if (response.statusCode == 200) {
          response = await Dio().post(
            '$STUDENT_API/address',
            data: {
              'regNumber': regNum,
              'addressDetails': data['addressDetails']
            },
          );
          log("address updated");

          if (response.statusCode == 200) {
            response = await Dio().post(
              '$STUDENT_API/education',
              data: {
                'regNumber': regNum,
                'educationDetails': data['educationDetails']
              },
            );
            log("education updated");

            if (response.statusCode == 200) {
              await ref
                  .read(finalController)
                  .valueUpdate(response.data['uniqueID']);

              response = await Dio().post(
                '$STUDENT_API/contact',
                data: {
                  'regNumber': regNum,
                  'contactDetails': data['contactDetails']
                },
              );
              log("contacts Updated");
              log(ref.watch(regNumController).edited.toString());
              if (response.statusCode == 200) {
                response = await Dio().post(
                  '$ADMIN_API/tx',
                  data: {
                    'transactionDetails': {
                      'regNumber': regNum,
                      'uniqueID': ref.watch(finalController).uniqueId,
                      'typee': txId == '' ? 'Cash' : 'Online',
                      'txId': txId == '' ? '-' : txId,
                      'pur': data['editDetails'],
                      'amt': isEdit ? '50' : '100',
                      'pay_status': 'Success',
                    }
                  },
                );
                log("transactions Updated");

                if (response.statusCode == 200) {
                  response = await Dio().post(
                    '$STUDENT_API/photo',
                    data: {
                      'regNumber': regNum,
                      'photoDetails': {'photo': imageData},
                    },
                  );
                  log('photo updated');

                  if (response.statusCode == 200) {
                    EasyLoading.dismiss();

                    await ref
                        .read(finalController)
                        .imageUpdate(prefs.getString('imageData'));

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalScreen(isEdit: isEdit),
                      ),
                      (route) => false,
                    );
                  } else {
                    EasyLoading.dismiss();
                    EasyLoading.showError('Failed. Please Retry');
                  }
                } else {
                  EasyLoading.dismiss();
                  EasyLoading.showError('Failed. Please Retry');
                }
              } else {
                EasyLoading.dismiss();
                EasyLoading.showError('Failed. Please Retry');
              }
            } else {
              log(response.toString());
              EasyLoading.dismiss();
              EasyLoading.showError('Failed. Please Retry');
            }
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError('Failed. Please Retry');
          }
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError('Failed. Please Retry');
        }
      }
    } catch (e) {
      log(e.toString());
      EasyLoading.dismiss();
      EasyLoading.showError('Failed. Please Retry');
    }
    notifyListeners();
  }

  valueUpdate() {
    notifyListeners();
  }

  clearText() {
    _uniqueIDTextController.text = '';
    notifyListeners();
  }
}
