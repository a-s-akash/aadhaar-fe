import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/UniqueID_Page/uniqueID_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/UniqueID_Page/uniqueID_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegNumScreen extends ConsumerWidget {
  final bool isEdit;
  const RegNumScreen({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool canProceed =
        ref.watch(regNumController).regNumTextController.text.isNotEmpty;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, r) {
        ref.read(regNumController).clearText();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: Center(
          child: Container(
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
                  "Enter Register Number",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      isEdit
                          ? "Please enter your Registration Number to edit your details"
                          : "Please enter your Registration Number to access student services.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      )),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    ref.read(regNumController).valueUpdate();
                  },
                  controller: ref.watch(regNumController).regNumTextController,
                  decoration: InputDecoration(
                    hintText: "Enter your Reg Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!canProceed) {
                        EasyLoading.showError("Please fill the field");
                        return;
                      } else {
                        EasyLoading.show();
                        FocusScope.of(context).unfocus();
                        isEdit
                            ? await ref
                                .read(regNumController)
                                .recognizeFace(context, ref)
                            : {
                                EasyLoading.show(dismissOnTap: false),
                                await ref
                                    .read(regNumController)
                                    .sendData(context, ref, isEdit)
                              };
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: canProceed ? Colors.blue : Colors.grey,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        const Text("continue", style: TextStyle(fontSize: 18)),
                  ),
                ),
                if (isEdit)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Or go with ",
                              style: TextStyle(fontSize: 16),
                            ),
                            TextSpan(
                              text: "Unique ID",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  ref.read(uniqueIDController).clearText();

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UniqueIDScreen(),
                                      ));
                                },
                            ),
                          ],
                        ),
                      )
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
