import 'package:aadhaar_flutter/pages/View/Dashboard_Page/dashboard_controller.dart';
import 'package:aadhaar_flutter/pages/View/Dashboard_Page/dashboard_screen.dart';
import 'package:aadhaar_flutter/pages/Authentication/Login_Page/login_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:html' as html;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String userName = html.window.localStorage['username'] ?? "";
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const Text('Student Service',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30)),
                Spacer(),
                Text('Welcome $userName',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20)),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () async {
                    EasyLoading.show(dismissOnTap: false);
                    FocusScope.of(context).unfocus();
                    await ref
                        .read(dashboardController)
                        .getDetails(context, ref, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DashboardScreen(isAdmin: true),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 16, 16, 16),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Admin Dashboard",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () async {
                    EasyLoading.show(dismissOnTap: false);
                    FocusScope.of(context).unfocus();
                    await ref.read(loginController).logout(context, ref);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: const Color.fromARGB(255, 60, 56, 93),
                          width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        size: 20,
                        color: Colors.white,
                      ),
                      const Text(" Logout",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 1, 44, 79),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 150),
                Text(
                  'Manage your student records efficiently with\nStudent Services Portal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      color: const Color.fromARGB(255, 84, 82, 82)),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(children: [
                        const Text('Create New User',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        const SizedBox(height: 10),
                        const Text(
                          "Start entering a new student's details.",
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegNumScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text("Create User",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(width: 50),
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(children: [
                        const Text('View Past Users',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        const SizedBox(height: 10),
                        const Text(
                          "See the list of previously created users.",
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            EasyLoading.show(dismissOnTap: false);
                            FocusScope.of(context).unfocus();
                            await ref
                                .read(dashboardController)
                                .getDetails(context, ref);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text("View Users",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(width: 50),
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(children: [
                        const Text('Edit User Info',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        const SizedBox(height: 10),
                        const Text(
                          "Update or correct user details.",
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RegNumScreen(isEdit: true),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.orange, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text("Edit User",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
