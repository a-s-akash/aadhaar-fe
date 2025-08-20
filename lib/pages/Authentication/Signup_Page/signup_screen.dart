import 'package:aadhaar_flutter/pages/Authentication/Login_Page/login_screen.dart';
import 'package:aadhaar_flutter/pages/Authentication/Signup_Page/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool passwordVisible = ref.watch(signupController).passwordVisible;
    bool canProceed =
        ref.watch(signupController).userNameTextController.text.isNotEmpty &&
            ref.watch(signupController).pwdTextController.text.isNotEmpty &&
            ref.watch(signupController).nameTextController.text.isNotEmpty &&
            ref.watch(signupController).rePwdTextController.text.isNotEmpty &&
            ref.watch(signupController).accNameTextController.text.isNotEmpty &&
            ref.watch(signupController).accNumTextController.text.isNotEmpty;

    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Welcome to Students Services',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                const SizedBox(height: 40),
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(30),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Signup",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Credential Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            )),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Name",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            )),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          ref.read(signupController).valueUpdate();
                        },
                        controller:
                            ref.watch(signupController).nameTextController,
                        decoration: InputDecoration(
                          hintText: "Enter name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Username",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            )),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          ref.read(signupController).valueUpdate();
                        },
                        controller:
                            ref.watch(signupController).userNameTextController,
                        decoration: InputDecoration(
                          hintText: "Enter username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Password",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            )),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        obscureText: passwordVisible,
                        onChanged: (value) {
                          ref.read(signupController).valueUpdate();
                        },
                        controller:
                            ref.watch(signupController).pwdTextController,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Re-Enter Password",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            )),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        obscureText: passwordVisible,
                        onChanged: (value) {
                          ref.read(signupController).valueUpdate();
                        },
                        controller:
                            ref.watch(signupController).rePwdTextController,
                        decoration: InputDecoration(
                          hintText: "Re-Enter password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              ref
                                  .read(signupController)
                                  .passwordVisibleChange();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Bank Account Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            )),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Account Holder Name",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            )),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          ref.read(signupController).valueUpdate();
                        },
                        controller:
                            ref.watch(signupController).accNameTextController,
                        decoration: InputDecoration(
                          hintText: "Enter Account Holder Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Account No.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            )),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        onChanged: (value) {
                          ref.read(signupController).valueUpdate();
                        },
                        controller:
                            ref.watch(signupController).accNumTextController,
                        decoration: InputDecoration(
                          hintText: "Enter Acc No.",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!canProceed) {
                              EasyLoading.showError("Please fill all fields");
                              return;
                            }
                            EasyLoading.show(status: 'Creating account...');
                            FocusScope.of(context).unfocus();
                            await ref
                                .read(signupController)
                                .createUser(context, ref);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                canProceed ? Colors.blue : Colors.grey,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Signup",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          GestureDetector(
                            onTap: () => {
                              ref.read(signupController).clearText(),
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              )
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
