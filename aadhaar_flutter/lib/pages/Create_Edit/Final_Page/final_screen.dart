// import 'dart:convert';
// import 'dart:developer';

// import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_controller.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/Address_Details_Page/addr_details_controller.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/Core_Details_Page/core_details_controller.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/Educational_Details_Page/edu_details_controller.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/Final_Page/final_controller.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/UniqueID_Page/uniqueID_controller.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
// import 'package:aadhaar_flutter/pages/Home_Page/home_screen.dart';
// import 'package:aadhaar_flutter/utils/constants.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dart:html' as html;

// import 'package:aadhaar_flutter/pages/Create_Edit/Contact_Details_Page/contact_details_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FinalScreen extends ConsumerWidget {
//   final bool isEdit;
//   const FinalScreen({super.key, this.isEdit = false});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final capturedImage = base64Decode(ref.watch(finalController).imageData);
//     final jsonString = html.window.localStorage['sendData'];
//     final Map<String, dynamic> data = jsonDecode(jsonString!);
//     final String uniqueId = ref.watch(finalController).uniqueId;

//     return PopScope(
//       canPop: true,
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF6F6F6),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               isEdit
//                   ? Text('Your Details Updated Successfully!',
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 33, 147, 37),
//                       ))
//                   : Text('Registration Successful!',
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 33, 147, 37),
//                       )),
//               const SizedBox(height: 30),
//               Container(
//                 width: 800,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(mainAxisSize: MainAxisSize.min, children: [
//                   Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 200,
//                               height: 200,
//                               clipBehavior: Clip.hardEdge,
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.black),
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.black,
//                               ),
//                               child: Image.memory(
//                                 capturedImage!,
//                                 width: 200,
//                                 height: 200,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             const SizedBox(width: 30),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "${data['nameDetails']['firstName']} ${data['nameDetails']['middleName']} ${data['nameDetails']['lastName']}",
//                                   style: TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold,
//                                     color:
//                                         const Color.fromARGB(221, 4, 24, 172),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "D.O.B: ",
//                                       style: TextStyle(
//                                         fontSize: 30,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Text(
//                                       data['nameDetails']['dob'],
//                                       style: TextStyle(
//                                         fontSize: 30,
//                                         color: const Color.fromARGB(
//                                             221, 4, 24, 172),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Gender: ",
//                                       style: TextStyle(
//                                         fontSize: 30,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Text(
//                                       data['nameDetails']['gender'],
//                                       style: TextStyle(
//                                         fontSize: 30,
//                                         color: const Color.fromARGB(
//                                             221, 4, 24, 172),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   uniqueId,
//                                   style: TextStyle(
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.bold,
//                                     color:
//                                         const Color.fromARGB(221, 4, 24, 172),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//               ),
//               const SizedBox(height: 50),
//               ElevatedButton(
//                 onPressed: () async {
//                   FocusScope.of(context).unfocus();

//                   html.window.location.reload();
//                   html.window.location.href = "http://localhost:56789/";

//                   await Future.delayed(const Duration(seconds: 2));
//                   await Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const HomeScreen(),
//                     ),
//                     (route) => false,
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.home, size: 20, color: Colors.white),
//                     const Text(" Return to Home ",
//                         style: TextStyle(fontSize: 18)),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   FocusScope.of(context).unfocus();

//                   try {
//                     final response = await Dio().post(
//                       '$baseURL/mail/send',
//                       data: {
//                         "toId": data["contactDetails"]["email"],
//                         "image" : base64Encode(capturedImage!)
//                       },
//                     );
//                     if (response.statusCode == 200) {
//                       EasyLoading.showSuccess("Mail sent successfully!");
//                     } else {
//                       EasyLoading.showInfo("Please retry!");
//                     }
//                   } catch (e) {
//                     EasyLoading.showInfo("Please retry!");
//                     log("Error: $e");
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.home, size: 20, color: Colors.white),
//                     const Text(" Send to Mail ",
//                         style: TextStyle(fontSize: 18)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Address_Details_Page/addr_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Core_Details_Page/core_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Educational_Details_Page/edu_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Final_Page/final_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/UniqueID_Page/uniqueID_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:aadhaar_flutter/pages/Home_Page/home_screen.dart';
import 'package:aadhaar_flutter/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:html' as html;

import 'package:aadhaar_flutter/pages/Create_Edit/Contact_Details_Page/contact_details_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';

class FinalScreen extends ConsumerWidget {
  final bool isEdit;
  FinalScreen({super.key, this.isEdit = false});

  // Key for capturing the widget as image
  final GlobalKey _captureKey = GlobalKey();

  Future<String> _captureContainerAsBase64() async {
    try {
      RenderRepaintBoundary boundary = _captureKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List pngBytes = byteData!.buffer.asUint8List();

      String base64String = base64Encode(pngBytes);
      return base64String;
    } catch (e) {
      log("Error capturing image: $e");
      return "";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capturedImage = base64Decode(ref.watch(finalController).imageData);
    final jsonString = html.window.localStorage['sendData'];
    final Map<String, dynamic> data = jsonDecode(jsonString!);
    final String uniqueId = ref.watch(finalController).uniqueId;

    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isEdit
                  ? Text(
                      'Your Details Updated Successfully!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 33, 147, 37),
                      ),
                    )
                  : Text(
                      'Registration Successful!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 33, 147, 37),
                      ),
                    ),
              const SizedBox(height: 30),

              // Wrapping in RepaintBoundary for capturing
              RepaintBoundary(
                key: _captureKey,
                child: Container(
                  width: 800,
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
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                  capturedImage,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data['nameDetails']['firstName']} ${data['nameDetails']['middleName']} ${data['nameDetails']['lastName']}",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(221, 4, 24, 172),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "D.O.B: ",
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        data['nameDetails']['dob'],
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: const Color.fromARGB(
                                              221, 4, 24, 172),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Gender: ",
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        data['nameDetails']['gender'],
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: const Color.fromARGB(
                                              221, 4, 24, 172),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    uniqueId,
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(221, 4, 24, 172),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),

              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  html.window.location.reload();
                  html.window.location.href = "http://localhost:56789/";

                  await Future.delayed(const Duration(seconds: 2));
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.home, size: 20, color: Colors.white),
                    Text(" Return to Home ", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    String base64Image = await _captureContainerAsBase64();

                    if (base64Image.isEmpty) {
                      EasyLoading.showInfo("Failed to capture image!");
                      return;
                    }
                    log(base64Image);

                    final response = await Dio().post(
                      '$baseURL/mail/image',
                      data: {
                        "toId": data["contactDetails"]["email"],
                        "image": base64Image,
                      },
                    );

                    if (response.statusCode == 200) {
                      EasyLoading.showSuccess("Mail sent successfully!");
                    } else {
                      EasyLoading.showInfo("Please retry!");
                    }
                  } catch (e) {
                    EasyLoading.showInfo("Please retry!");
                    log("Error: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.mail, size: 20, color: Colors.white),
                    Text(" Send to Mail ", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
