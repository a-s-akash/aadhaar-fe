import 'dart:convert';

import 'package:aadhaar_flutter/pages/View/Dashboard_Page/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  final bool isAdmin;
  const DashboardScreen({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, String>> studentsList =
        ref.watch(dashboardController).studentsList;
    return PopScope(
      canPop: true,
      child: Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: AppBar(
            foregroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(isAdmin ? 'Admin DashBoard' : 'Students DashBoard',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 30)),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 1, 44, 79),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: IntrinsicWidth(
                      child: DataTable(
                        columnSpacing: 20,
                        headingRowHeight: 50,
                        dataRowHeight: 60,
                        columns: isAdmin
                            ? const [
                                DataColumn(
                                    label: Center(
                                        child: Text('Reg Number',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Unique ID',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Operation',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                  DataColumn(
                                    label: Center(
                                        child: Text('Purpose',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Payment Mode',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Transaction ID',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Amount',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Status',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Time',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                              ]
                            : const [
                                DataColumn(
                                    label: Center(
                                        child: Text('Photo',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Reg Number',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Phone',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Email',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Degree',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('College',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                DataColumn(
                                    label: Center(
                                        child: Text('Unique ID',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                              ],
                        rows: studentsList.map((student) {
                          return isAdmin
                              ? DataRow(cells: [
                                  DataCell(Text(student['regNumber'] ?? '')),
                                  DataCell(Text(student['uniqueID'] ?? '')),
                                  DataCell(Text(student['operation'] ?? '')),
                                  DataCell(Text(student['purpose'] ?? '')),
                                  DataCell(Text(student['mode'] ?? '')),
                                  DataCell(
                                      Text(student['TransactionID'] ?? '')),
                                  DataCell(Text(student['amt'] ?? '')),
                                  DataCell(Text(student['status'] ?? '',
                                      style: TextStyle(
                                          color: student['status'] == "Success"
                                              ? Colors.green
                                              : Colors.red))),
                                  DataCell(Text(student['time'] ?? '')),
                                ])
                              : DataRow(cells: [
                                  DataCell(
                                    student['photo'] != null &&
                                            student['photo'] != ''
                                        ? Image.memory(
                                            base64Decode(
                                                student['photo'].toString()),
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          )
                                        : const Icon(Icons.person),
                                  ),
                                  DataCell(Text(student['regNumber'] ?? '')),
                                  DataCell(Text(student['name'] ?? '')),
                                  DataCell(Text(student['phone'] ?? '')),
                                  DataCell(Text(student['email'] ?? '')),
                                  DataCell(Text(student['degree'] ?? '')),
                                  DataCell(Text(student['college'] ?? '')),
                                  DataCell(Text(student['uniqueID'] ?? '')),
                                ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
