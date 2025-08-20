import 'package:aadhaar_flutter/pages/Create_Edit/Core_Details_Page/core_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoreDetailsScreen extends ConsumerWidget {
  const CoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool canProceed = ref
            .watch(coreDetailsController)
            .firstNameController
            .text
            .isNotEmpty &&
        ref.watch(coreDetailsController).lastNameController.text.isNotEmpty &&
        ref.watch(coreDetailsController).dateController.text.isNotEmpty &&
        ref.watch(coreDetailsController).gender.isNotEmpty &&
        ref.watch(coreDetailsController).fatherNameController.text.isNotEmpty &&
        ref.watch(coreDetailsController).motherNameController.text.isNotEmpty &&
        ref
            .watch(coreDetailsController)
            .placeOfBirthController
            .text
            .isNotEmpty &&
        ref.watch(coreDetailsController).nationalityController.text.isNotEmpty;
    String? gender = ref.watch(coreDetailsController).gender;
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
                    "Core Identity Information",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 28, 50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Full Name",
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
                          onChanged: (value) async {
                            await ref
                                .read(coreDetailsController)
                                .valueUpdate(ref);
                          },
                          controller: ref
                              .watch(coreDetailsController)
                              .firstNameController,
                          decoration: InputDecoration(
                            hintText: "First Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (value) async {
                            await ref
                                .read(coreDetailsController)
                                .valueUpdate(ref);
                          },
                          controller: ref
                              .watch(coreDetailsController)
                              .middleNameController,
                          decoration: InputDecoration(
                            hintText: "Middle Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (value) async {
                            await ref
                                .read(coreDetailsController)
                                .valueUpdate(ref);
                          },
                          controller: ref
                              .watch(coreDetailsController)
                              .lastNameController,
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Date of Birth",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: ref.watch(coreDetailsController).dateController,
                    readOnly: true,
                    onTap: () async => await ref
                        .read(coreDetailsController)
                        .selectDate(context, ref),
                    decoration: InputDecoration(
                      hintText: "Select date",
                      suffixIcon: const Icon(Icons.calendar_today),
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
                    child: Text("Gender",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: gender.isNotEmpty ? gender : null,
                    hint: const Text("Select Your Gender"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                    ),
                    items: ['Male', 'Female', 'Other'].map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        ref
                            .read(coreDetailsController)
                            .valueUpdate(ref, value, "gender");
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Father's Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) async {
                      await ref.read(coreDetailsController).valueUpdate(ref);
                    },
                    controller:
                        ref.watch(coreDetailsController).fatherNameController,
                    decoration: InputDecoration(
                      hintText: "Father's Name",
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
                    child: Text("Mother's Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) async {
                      await ref.read(coreDetailsController).valueUpdate(ref);
                    },
                    controller:
                        ref.watch(coreDetailsController).motherNameController,
                    decoration: InputDecoration(
                      hintText: "Mother's Name",
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
                    child: Text("Place of Birth",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) async {
                      await ref.read(coreDetailsController).valueUpdate(ref);
                    },
                    controller:
                        ref.watch(coreDetailsController).placeOfBirthController,
                    decoration: InputDecoration(
                      hintText: "City/Town, State, Country",
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
                    child: Text("Nationality",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (value) async {
                      await ref.read(coreDetailsController).valueUpdate(ref);
                    },
                    controller:
                        ref.watch(coreDetailsController).nationalityController,
                    decoration: InputDecoration(
                      hintText: "Nationality",
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
                              .read(coreDetailsController)
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
