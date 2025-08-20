import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aadhaar_flutter/pages/Create_Edit/Contact_Details_Page/contact_details_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ContactDetailsScreen extends ConsumerWidget {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mobileNumTextController =
        ref.watch(contactDetailsController).mobileNumTextController;
    final mobileOTPTextController =
        ref.watch(contactDetailsController).mobileOTPTextController;
    final mailIdTextController =
        ref.watch(contactDetailsController).mailIdTextController;
    final mailOTPTextController =
        ref.watch(contactDetailsController).mailOTPTextController;
    final isMobileVerified =
        ref.watch(contactDetailsController).isMobileVerified;
    final showMobileOTPField =
        ref.watch(contactDetailsController).showMobileOTPField;
    final isMailVerified = ref.watch(contactDetailsController).isMailVerified;
    final showMailOTPField =
        ref.watch(contactDetailsController).showMailOTPField;
    final showgetOTPMail = ref.watch(contactDetailsController).showgetOTPMail;
    final showgetOTPMobile =
        ref.watch(contactDetailsController).showgetOTPMobile;
    final bool showQR = ref.watch(contactDetailsController).showQR;
    final String qrData = ref.watch(contactDetailsController).qrData;

    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 1000,
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
                    "Contact Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 28, 50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Mobile Number",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: mobileNumTextController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          onChanged: ref
                              .read(contactDetailsController)
                              .onMobileChanged,
                          decoration: InputDecoration(
                            hintText: "Enter your Mobile Number",
                            suffixIcon: isMobileVerified
                                ? Icon(Icons.check_circle, color: Colors.green)
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (!isMobileVerified && showgetOTPMobile)
                        ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            if (mobileNumTextController.text.length == 10) {
                              await ref
                                  .read(contactDetailsController)
                                  .getMobileOtp(ref);
                            } else {
                              EasyLoading.showError(
                                  "Enter valid mobile number");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                mobileNumTextController.text.length == 10
                                    ? Colors.green
                                    : Colors.grey,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Generate OTP"),
                        )
                    ],
                  ),
                  if (showMobileOTPField && !isMobileVerified)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                ref
                                    .read(contactDetailsController)
                                    .validateMobileOtp();
                              },
                              controller: mobileOTPTextController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter OTP",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Mail ID",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: mailIdTextController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged:
                              ref.read(contactDetailsController).onMailChanged,
                          decoration: InputDecoration(
                            hintText: "Enter your Mail ID",
                            suffixIcon: isMailVerified
                                ? Icon(Icons.check_circle, color: Colors.green)
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (!isMailVerified && showgetOTPMail)
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            final email = mailIdTextController.text;
                            if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(email)) {
                              ref
                                  .read(contactDetailsController)
                                  .getMailOtp(ref);
                            } else {
                              EasyLoading.showError("Enter valid email");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(mailIdTextController.text)
                                    ? Colors.green
                                    : Colors.grey,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Generate OTP"),
                        )
                    ],
                  ),
                  if (showMailOTPField && !isMailVerified)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                if (value.length == 6) {
                                  ref
                                      .read(contactDetailsController)
                                      .validateMailOtp();
                                }
                              },
                              controller: mailOTPTextController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter OTP",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isMobileVerified && isMailVerified) {
                            EasyLoading.show(dismissOnTap: false);
                            FocusScope.of(context).unfocus();
                            await ref
                                .read(contactDetailsController)
                                .sendData(context, ref);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isMobileVerified && isMailVerified
                              ? Colors.green
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(" next ",
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (showQR)
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 300.0,
                      backgroundColor: Colors.white,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
