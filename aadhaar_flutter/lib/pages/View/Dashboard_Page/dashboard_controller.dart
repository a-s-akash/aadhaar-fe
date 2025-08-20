import 'dart:developer';

import 'package:aadhaar_flutter/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardController =
    ChangeNotifierProvider<DashboardProvider>((ref) => DashboardProvider());

class DashboardProvider extends ChangeNotifier {
  List<Map<String, String>> _studentsList = [];

  getDetails(context, ref, [isAdmin = false]) async {
    try {
      final response = isAdmin
          ? await Dio().get('$ADMIN_API/dash')
          : await Dio().get('$STUDENT_API/all');

      if (response.statusCode == 200) {
        List data = response.data as List;

        _studentsList = isAdmin
            ? data.map<Map<String, String>>((item) {
                return {
                  'regNumber': item['transactionDetails']['regNumber'] ?? '',
                  'uniqueID': item['transactionDetails']['uniqueID'] ?? '',
                  'purpose':
                      (item['transactionDetails']['pur'] as List).join(', '),
                  'operation': item['transactionDetails']['amt'] == '50'
                      ? "Edit"
                      : "Creation",
                  'TransactionID': item['transactionDetails']['txId'],
                  'mode': item['transactionDetails']['typee'],
                  'amt': item['transactionDetails']['amt'],
                  'status': item['transactionDetails']['pay_status'],
                  'time': item['updatedAt']
                };
              }).toList()
            : data.map<Map<String, String>>((item) {
                return {
                  'regNumber': item['regNumber']?.toString() ?? '',
                  'name':
                      "${item['nameDetails']?['firstName'] ?? ''} ${item['nameDetails']?['lastName'] ?? ''}",
                  'degree': item['educationDetails']?['degree'] ?? '',
                  'college': item['educationDetails']?['collegeName'] ?? '',
                  'phone': item['contactDetails']?['mobile'] ?? '',
                  'email': item['contactDetails']?['email'] ?? '',
                  'uniqueID': item['uniqueID']?.toString() ?? '',
                  'photo': item['photoDetails']?['photo'] ?? ''
                };
              }).toList();
        EasyLoading.dismiss();
      } else {
        log('Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Fetch failed: $e');
    }
    notifyListeners();
  }

  valueUpdate() {
    notifyListeners();
  }

  clearText() {
    notifyListeners();
  }

  List<Map<String, String>> get studentsList => _studentsList;
}
