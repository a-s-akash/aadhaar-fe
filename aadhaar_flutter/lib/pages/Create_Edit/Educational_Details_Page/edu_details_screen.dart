import 'package:aadhaar_flutter/pages/Create_Edit/Educational_Details_Page/edu_details_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EduDetailsScreen extends ConsumerWidget {
  const EduDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEdit = ref.watch(regNumController).isEdit;
    String collegeName = ref.watch(eduDetailsController).collegeName;
    String degreeName = ref.watch(eduDetailsController).degreeName;
    String yearOfJoining = ref.watch(eduDetailsController).yearOfJoining;
    String yearOfCompletion = ref.watch(eduDetailsController).yearOfCompletion;
    String courseName = ref.watch(eduDetailsController).courseName;
    List courseList = ref.watch(eduDetailsController).courseList;
    List degreeList = ref.watch(eduDetailsController).degreeList;
    List joiningYearList = ref.watch(eduDetailsController).joiningYearList;
    List completionYearList =
        ref.watch(eduDetailsController).completionYearList;
    bool canProceed = ref.watch(eduDetailsController).collegeName.isNotEmpty &&
        ref.watch(eduDetailsController).degreeName.isNotEmpty &&
        ref.watch(eduDetailsController).yearOfJoining.isNotEmpty &&
        ref.watch(eduDetailsController).yearOfCompletion.isNotEmpty &&
        ref.watch(eduDetailsController).courseName.isNotEmpty;
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
                    "Educational Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 28, 50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Register Number",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText:
                          ref.watch(regNumController).regNumTextController.text,
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
                    child: Text("College Name",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 8),
                  // TextField(
                  //   onChanged: (value) async {
                  //     await ref.read(eduDetailsController).valueUpdate();
                  //   },
                  //   controller:
                  //       ref.watch(eduDetailsController).collegeNameTextController,
                  //   decoration: InputDecoration(
                  //     hintText: "College Name",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     contentPadding: const EdgeInsets.symmetric(
                  //         horizontal: 12, vertical: 14),
                  //   ),
                  // ),
                  DropdownButtonFormField<String>(
                    value: collegeName.isNotEmpty ? collegeName : null,
                    hint: const Text("Select Your College"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                    ),
                    items: [
                      "PSG College of Technology",
                      "Coimbatore Institute of Technology",
                      "Kumaraguru College of Technology",
                      "KPR Institute of Engineering and Technology",
                      "Sri Krishna College of Engineering and Technology",
                      "Government College of Technology, Coimbatore",
                      "SNS College of Technology",
                      "Adithya Institute of Technology",
                      "Dr. N.G.P. Institute of Technology",
                      "CMS College of Engineering and Technology"
                    ].map((college) {
                      return DropdownMenuItem(
                        value: college,
                        child: Text(college),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        ref
                            .read(eduDetailsController)
                            .valueUpdate("collegeName", value, ref,1);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Degree & Specialization",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),  
                  const SizedBox(height: 8),
                  // TextField(
                  //   onChanged: (value) async {
                  //     // await ref.read(eduDetailsController).valueUpdate();
                  //   },
                  //   controller:
                  //       ref.watch(eduDetailsController).degreeNameTextController,
                  //   decoration: InputDecoration(
                  //     hintText: "Degree",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     contentPadding: const EdgeInsets.symmetric(
                  //         horizontal: 12, vertical: 14),
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: degreeName.isNotEmpty &&
                                  degreeList.contains(degreeName)
                              ? degreeName
                              : null,
                          hint: const Text("Select Your Degree"),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          items: degreeList
                              .map<DropdownMenuItem<String>>((degree) {
                            return DropdownMenuItem(
                              value: degree,
                              child: Text(degree),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(eduDetailsController)
                                  .valueUpdate("degreeName", value, ref,1);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: courseList.contains(courseName) &&
                                  courseName.isNotEmpty
                              ? courseName
                              : null,
                          hint: const Text("Select Your course"),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          items: courseList
                              .map<DropdownMenuItem<String>>((course) {
                            return DropdownMenuItem(
                              value: course,
                              child: Text(course),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(eduDetailsController)
                                  .valueUpdate("courseName", value, ref,1);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Academic Years",
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
                        child: DropdownButtonFormField<String>(
                          value: joiningYearList.contains(yearOfJoining) &&
                                  yearOfJoining.isNotEmpty
                              ? yearOfJoining
                              : null,
                          hint: const Text("Year of Joining"),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          items: joiningYearList
                              .map<DropdownMenuItem<String>>((join) {
                            return DropdownMenuItem(
                              value: join,
                              child: Text(join),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(eduDetailsController)
                                  .valueUpdate("yearOfJoining", value, ref,1);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value:
                              completionYearList.contains(yearOfCompletion) &&
                                      yearOfCompletion.isNotEmpty
                                  ? yearOfCompletion
                                  : null,
                          hint: const Text("Year of Completion"),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          items: completionYearList
                              .map<DropdownMenuItem<String>>((complete) {
                            return DropdownMenuItem(
                              value: complete,
                              child: Text(complete),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(eduDetailsController)
                                  .valueUpdate("yearOfCompletion", value, ref,1);
                            }
                          },
                        ),
                      ),
                    ],
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
                              .read(eduDetailsController)
                              .sendData(context, ref, isEdit);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              canProceed ? Colors.green : Colors.grey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(" next ", style: TextStyle(fontSize: 18)),
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
