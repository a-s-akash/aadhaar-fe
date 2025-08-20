import 'dart:developer';
import 'package:aadhaar_flutter/pages/Authentication/Login_Page/login_screen.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Payment_Page/payment_screen.dart';
import 'package:aadhaar_flutter/pages/Home_Page/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:html' as html;
import 'utils/constants.dart';
import 'utils/custom_loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  runApp(
    ProviderScope(
      child: MyApp(
        isLoggedIn: html.window.localStorage.containsKey('username'),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isPayment = false;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    _sendDataIfAvailable();
  }

  Future<void> _sendDataIfAvailable() async {
    final uri = Uri.base;
    final encryptedData = uri.queryParameters['data'];

    if (encryptedData != null) {
      try {
        final response = await Dio().post(
          '$baseURL/mail/uri',
          data: {"uri": encryptedData},
        );

        if (response.statusCode == 200) {
          log("✅ API Success: ${response.data}");
          setState(() {
            data = Map<String, dynamic>.from(response.data);
            isPayment = true;
          });
        } else {
          log("⚠️ API Error: ${response.data}");
        }
      } catch (e) {
        log("❌ API Exception: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      builder: EasyLoading.init(),
      home: isPayment
          ? PaymentScreen(data: data)
          : widget.isLoggedIn
              ? const HomeScreen()
              : const LoginScreen(),
    );
  }
}

// import 'dart:convert';
// import 'dart:developer';

// import 'package:aadhaar_flutter/pages/Authentication/Login_Page/login_screen.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/Contact_Details_Page/contact_details_screen.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/Final_Page/final_screen.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/Payment_Page/payment_screen.dart';
// import 'package:aadhaar_flutter/pages/Create_Edit/Show_Details_Page/show_details_screen.dart';
// import 'package:aadhaar_flutter/pages/Home_Page/home_screen.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'utils/constants.dart';
// import 'dart:html' as html;
// import 'utils/custom_loading.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   configLoading();
//   runApp(ProviderScope(
//       child:
//           MyApp(isLoggedIn: html.window.localStorage.containsKey('username'))));
// }

// // class MyApp extends StatelessWidget {
// //   final bool isLoggedIn;
// //   const MyApp({super.key, required this.isLoggedIn});

// //   @override
// //   Widget build(BuildContext context) {
// //     final uri = Uri.base;
// //     final encryptedData = uri.queryParameters['data'];
// //     if (encryptedData != null) {
// //       try {
// //       final response = await Dio().post(
// //         '$baseURL/mail/send',
// //         data: {
// //           "uri": encryptedData,
// //         },
// //       );
// //       if (response.statusCode == 200) {
// //         log(response.data);
// //       } else {
// //         log(response.data);
// //       }
// //     } catch (e) {
// //         log(e.toString());

// //       }
// //     }

// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: appName,
// //       builder: EasyLoading.init(),
// //       home:
// //           // txId != null
// //           //     ? const PaymentScreen()
// //           isLoggedIn ? const HomeScreen() : const LoginScreen(),
// //       // home: FinalScreen(isEdu: true, isEdit: true),
// //     );
// //   }
// class MyApp extends StatefulWidget {
//   final bool isLoggedIn;
//   bool isPayment;
//   MyApp({super.key, required this.isLoggedIn, this.isPayment = false});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     _sendDataIfAvailable();
//   }

//   Future<void> _sendDataIfAvailable() async {
//     final uri = Uri.base;
//     final encryptedData = uri.queryParameters['data'];

//     if (encryptedData != null) {
//       try {
//         final response = await Dio().post(
//           '$baseURL/mail/uri',
//           data: {"uri": encryptedData},
//         );

//         if (response.statusCode == 200) {
//           log(response.data.toString());
//           widget.isPayment = true;
//         } else {
//           log(response.data.toString());
//         }
//       } catch (e) {
//         log(e.toString());
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: appName,
//       builder: EasyLoading.init(),
//       home: widget.isPayment
//           ? const PaymentScreen()
//           : widget.isLoggedIn
//               ? const HomeScreen()
//               : const LoginScreen(),
//     );
//   }
// }

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..textColor = Colors.white
    ..maskColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation()
    ..progressColor = Colors.white
    ..backgroundColor = const Color.fromARGB(255, 0, 0, 0)
    ..indicatorColor = Colors.white;
}
