import 'package:aadhaar_flutter/pages/Create_Edit/Payment_Page/payment_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentScreen extends ConsumerWidget {
  final Map data;
  const PaymentScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txId = data['data']['txId'];
    // final reference = data['reference'];
    // final merchant = data['merchant'];
    // final name = data['name'];
    // final accountNumber = data['accountNumber'];
    // final ifsc = data['ifsc'];
    // final amount = data['amount'];
    final status = data['data']['status'];
    // final timestamp = data['timestamp'];
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        body: Center(
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
                child: Text(
                    status == 'Success'
                        ? 'Payment Successfull!'
                        : 'Payment Failed!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: status == 'Success'
                          ? Color.fromARGB(255, 33, 147, 37)
                          : Colors.red,
                    )),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  "Transaction ID:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  txId ?? "",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  "Transaction Status:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  status ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    color: status == "Success" ? Colors.green : Colors.red,
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    EasyLoading.show();
                    status == 'Success'
                        ? await ref
                            .read(paymentController)
                            .sendData(context, ref, txId)
                        : await ref
                            .read(paymentController)
                            .rePayment(context, ref);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        status == 'Success' ? Colors.blue : Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    status == 'Success' ? "Continue" : "Retry Payment",
                    style: TextStyle(fontSize: 18),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
