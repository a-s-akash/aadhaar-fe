import 'dart:convert';
import 'dart:developer';

import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Address_Details_Page/addr_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Contact_Details_Page/contact_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Core_Details_Page/core_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Core_Details_Page/core_details_screen.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Educational_Details_Page/edu_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:aadhaar_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final uniqueIDController =
    ChangeNotifierProvider<UniqueIDProvider>((ref) => UniqueIDProvider());
final TextEditingController _uniqueIDTextController = TextEditingController();

class UniqueIDProvider extends ChangeNotifier {
  Future<void> recognizeFace(context, ref) async {
    try {
      final response = await Dio().post(
        '$STUDENT_API/checkId',
        data: {
          "uniqueID": _uniqueIDTextController.text,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        await ref.read(liveCamController).clearImage(true);
        if (await ref.watch(liveCamController).cameraPermission == true) {
          EasyLoading.show(status: 'Recognizing Face...');
          await Future.delayed(const Duration(seconds: 2));
          await ref.read(liveCamController).captureFrame();
          await Future.delayed(const Duration(milliseconds: 300));
          String takenBase64Image =
              await ref.watch(liveCamController).base64Json;
          await ref.read(liveCamController).clearImage();
          String base64Image = '';
          try {
            log('$STUDENT_API/photo/id/${_uniqueIDTextController.text}');
            final response = await Dio().get(
              '$STUDENT_API/photo/id/${_uniqueIDTextController.text}',
            );
            if (response.statusCode == 200) {
              base64Image = response.data['photo'] ?? '';
            }
          } on DioException catch (e) {
            EasyLoading.dismiss();

            log("DioError: ${e.response?.statusCode} ${e.response?.data}");

            EasyLoading.showError('Failed: ${e.response?.statusCode ?? ''}');
          } catch (e) {
            EasyLoading.dismiss();
            log(" General Error: $e");
            EasyLoading.showError('Unexpected Error');
          }
          final response = await Dio().post(
            FACE_MATCH_API,
            data:
                jsonEncode({"image1": base64Image, "image2": takenBase64Image}),
            options: Options(headers: {
              'Content-Type': 'application/json',
            }),
          );

          if (response.statusCode == 200) {
            final result = response.data['result'];
            EasyLoading.showSuccess("Result: $result");
            if (result == 'MATCH_FOUND') {
              EasyLoading.showSuccess("Face Matched Successfully");
              log('$STUDENT_API/details/id/${_uniqueIDTextController.text}');
              try {
                final response = await Dio().get(
                  '$STUDENT_API/details/id/${_uniqueIDTextController.text}',
                );
                if (response.statusCode == 200) {
                  await ref.read(regNumController).valueUpdate('edit');
                  await ref.read(regNumController).valueUpdate(
                      'regnum', response.data['student']['regNumber']);
                  notifyListeners();
                  await ref
                      .read(coreDetailsController)
                      .editValueUpdate(response.data['student']['nameDetails']);
                  await ref.read(addrDetailsController).editValueUpdate(
                      response.data['student']['addressDetails']);
                  await ref.read(eduDetailsController).editValueUpdate(
                      response.data['student']['educationDetails'], ref);
                  await ref.read(liveCamController).editValueUpdate(
                      response.data['student']['photoDetails']);
                  await ref.read(contactDetailsController).editValueUpdate(
                      response.data['student']['contactDetails']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CoreDetailsScreen(),
                    ),
                  );
                }
              } on DioException catch (e) {
                EasyLoading.dismiss();

                log("DioError: ${e.response?.statusCode} ${e.response?.data}");

                EasyLoading.showError(
                    'Failed: ${e.response?.statusCode ?? ''}');
              } catch (e) {
                EasyLoading.dismiss();
                log(" General Error: $e");
                EasyLoading.showError('Unexpected Error');
              }
            } else {
              EasyLoading.showError("Face Not Matched");
            }
          } else {
            EasyLoading.showError("Failed! Retry.");
          }
        } else {
          EasyLoading.showInfo(
              "Camera Permission Denied. Please allow camera access.");
        }
      } else {
        EasyLoading.showInfo("Unique ID Not Found");
      }
    } catch (e) {
      log("Dio Error: $e");
      EasyLoading.showError("Failed! Retry.");
    }
  }

  valueUpdate() {
    notifyListeners();
  }

  clearText() {
    _uniqueIDTextController.text = '';
    notifyListeners();
  }

  TextEditingController get uniqueIDTextController => _uniqueIDTextController;
}
