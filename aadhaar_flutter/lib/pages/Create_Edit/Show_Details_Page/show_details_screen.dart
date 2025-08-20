import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Address_Details_Page/addr_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Contact_Details_Page/contact_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Core_Details_Page/core_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Educational_Details_Page/edu_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Payment_Page/payment_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Show_Details_Page/show_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowDetailsScreen extends ConsumerWidget {
  const ShowDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    "Core Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 28, 50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  RowWidget(
                    label: "Name : ",
                    value:
                        "${ref.watch(coreDetailsController).firstNameController.text} ${ref.watch(coreDetailsController).middleNameController.text} ${ref.watch(coreDetailsController).lastNameController.text}",
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Date of Birth : ",
                    value: ref.watch(coreDetailsController).dateController.text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Gender : ",
                    value: ref.watch(coreDetailsController).gender,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Father's Name : ",
                    value: ref
                        .watch(coreDetailsController)
                        .fatherNameController
                        .text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Mother's Name : ",
                    value: ref
                        .watch(coreDetailsController)
                        .motherNameController
                        .text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Place of Birth : ",
                    value: ref
                        .watch(coreDetailsController)
                        .placeOfBirthController
                        .text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Nationality : ",
                    value: ref
                        .watch(coreDetailsController)
                        .nationalityController
                        .text,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Address Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 28, 50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  RowWidget(
                    label: "Residence Address : ",
                    value: ref
                        .watch(addrDetailsController)
                        .residenceAddrTextController
                        .text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Permanent Address : ",
                    value: ref
                        .watch(addrDetailsController)
                        .permanentAddrTextController
                        .text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "District : ",
                    value: ref
                        .watch(addrDetailsController)
                        .districtTextController
                        .text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "State : ",
                    value: ref
                        .watch(addrDetailsController)
                        .stateTextController
                        .text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Country : ",
                    value: ref
                        .watch(addrDetailsController)
                        .countryTextController
                        .text,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Education Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 28, 50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  RowWidget(
                    label: "Registration Number : ",
                    value:
                        ref.watch(regNumController).regNumTextController.text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "College Name : ",
                    value: ref.watch(eduDetailsController).collegeName,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Degree & Specialization : ",
                    value:
                        '${ref.watch(eduDetailsController).degreeName} ${ref.watch(eduDetailsController).courseName}',
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Academic Years : ",
                    value:
                        '${ref.watch(eduDetailsController).yearOfJoining} - ${ref.watch(eduDetailsController).yearOfCompletion}',
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Contact Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 28, 50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  RowWidget(
                    label: "Mobile : ",
                    value: ref
                        .watch(contactDetailsController)
                        .mobileNumTextController
                        .text,
                  ),
                  const SizedBox(height: 10),
                  RowWidget(
                    label: "Email : ",
                    value: ref
                        .watch(contactDetailsController)
                        .mailIdTextController
                        .text,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Photo for BioMetric",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 28, 50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 200,
                    height: 200,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: Image.memory(
                      ref.watch(liveCamController).capturedImage!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          // EasyLoading.show(dismissOnTap: false);
                          await ref
                              .read(showDetailsController)
                              .setSendData(ref);
                          FocusScope.of(context).unfocus();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Center(
                                  child: Icon(
                                Icons.warning,
                                color: const Color.fromARGB(255, 155, 3, 3),
                                size: 50,
                              )),
                              content: Text(
                                "Choose Your Payment Method",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            EasyLoading.show();
                                            await ref
                                                .read(paymentController)
                                                .sendData(context, ref);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text("Cash",
                                              style: TextStyle(fontSize: 18)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await ref
                                                .read(showDetailsController)
                                                .pay(context, ref);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text("Online Payment",
                                              style: TextStyle(fontSize: 18)),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(" Submit & Pay ",
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  final String label;
  final String value;
  const RowWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 1, 28, 50),
          ),
        ),
        const SizedBox(width: 20),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 1, 28, 50),
          ),
        ),
      ],
    );
  }
}
