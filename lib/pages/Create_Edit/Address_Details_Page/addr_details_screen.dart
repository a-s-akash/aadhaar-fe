import 'package:aadhaar_flutter/pages/Create_Edit/Address_Details_Page/addr_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddrDetailsScreen extends ConsumerWidget {
  const AddrDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool canProceed = ref
            .watch(addrDetailsController)
            .residenceAddrTextController
            .text
            .isNotEmpty &&
        ref
            .watch(addrDetailsController)
            .permanentAddrTextController
            .text
            .isNotEmpty &&
        ref
            .watch(addrDetailsController)
            .countryTextController
            .text
            .isNotEmpty &&
        ref.watch(addrDetailsController).stateTextController.text.isNotEmpty &&
        ref.watch(addrDetailsController).districtTextController.text.isNotEmpty;
    bool isSameAddr = ref.watch(addrDetailsController).isSameAddr;
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
                    "Address Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 28, 50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Residence Address",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) async {
                      await ref.read(addrDetailsController).valueUpdate(ref);
                    },
                    controller: ref
                        .watch(addrDetailsController)
                        .residenceAddrTextController,
                    decoration: InputDecoration(
                      hintText: "House No., Street, City, State, PIN",
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
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        const Text(
                          "Permanent Address",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: isSameAddr,
                              onChanged: (bool? value) async {
                                await ref
                                    .read(addrDetailsController)
                                    .switchAddr(value);
                              },
                            ),
                            const Text(
                              "Same as Residence Address",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) async {
                      await ref.read(addrDetailsController).valueUpdate(ref);
                    },
                    controller: ref
                        .watch(addrDetailsController)
                        .permanentAddrTextController,
                    enabled: !isSameAddr,
                    decoration: InputDecoration(
                      hintText: "House No., Street, City, State, PIN",
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
                    child: Text("District",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) async {
                      await ref.read(addrDetailsController).valueUpdate(ref);
                    },
                    controller:
                        ref.watch(addrDetailsController).districtTextController,
                    decoration: InputDecoration(
                      hintText: "District",
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
                    child: Text("State",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) async {
                      await ref.read(addrDetailsController).valueUpdate(ref);
                    },
                    controller:
                        ref.watch(addrDetailsController).stateTextController,
                    decoration: InputDecoration(
                      hintText: "State",
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
                    child: Text("Country",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) async {
                      await ref.read(addrDetailsController).valueUpdate(ref);
                    },
                    controller:
                        ref.watch(addrDetailsController).countryTextController,
                    decoration: InputDecoration(
                      hintText: "Country",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!canProceed) {
                            EasyLoading.showError(
                                "Please fill all the fields.");
                            return;
                          }
                          EasyLoading.show(dismissOnTap: false);
                          FocusScope.of(context).unfocus();
                          await ref
                              .read(addrDetailsController)
                              .sendData(context, ref);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              canProceed ? Colors.green : Colors.grey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(" next ",
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
