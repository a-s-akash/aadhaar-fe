import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_controller.dart';
import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_screen.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Show_Details_Page/show_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:html' as html;

final eduDetailsController = ChangeNotifierProvider<EducationDetailsProvider>(
    (ref) => EducationDetailsProvider());

class EducationDetailsProvider extends ChangeNotifier {
  Map<String, dynamic> _data = {};
  String _collegeName = '';
  String _degreeName = '';
  String _courseName = '';
  String _yearOfJoining = '';
  String _yearOfCompletion = '';
  List _courseList = [];
  List _degreeList = [];
  List _joiningYearList = [];
  List _completionYearList = [];

  sendData(context, ref, isEdit) async {
    _data = {
      'collegeName': _collegeName,
      'degree': _degreeName,
      'yearOfJoining': _yearOfJoining,
      'yearOfCompletion': _yearOfCompletion,
      'course': _courseName,
    };
    notifyListeners();

    EasyLoading.dismiss();
    if (!isEdit) {
      await ref.read(liveCamController).clearImage(true);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LiveCameraScreen(),
        ));
  }

  Future<void> valueUpdate(which, val, [ref, x = 0]) async {
    if (which == 'collegeName') {
      _collegeName = val;
      if ([
        "PSG College of Technology",
        "Coimbatore Institute of Technology",
        "Kumaraguru College of Technology",
      ].contains(val)) {
        _degreeList = ["B.E.", "M.E.", "M.Sc - Integrated", "MCA", "MBA"];
      } else if ([
        "KPR Institute of Engineering and Technology",
        "Sri Krishna College of Engineering and Technology",
        "Dr. N.G.P. Institute of Technology",
      ].contains(val)) {
        _degreeList = ["B.E.", "M.E.", "MCA", "MBA"];
      } else if ([
        "SNS College of Technology",
        "Adithya Institute of Technology",
        "CMS College of Engineering and Technology"
      ].contains(val)) {
        _degreeList = ["B.E.", "M.E.", "MBA"];
      } else {
        _degreeList = ["B.E.", "M.E."];
      }
      _degreeName = '';
      _courseName = '';
      _yearOfJoining = '';
      _yearOfCompletion = '';
    } else if (which == 'degreeName') {
      _degreeName = val;
      if (val == 'B.E.') {
        _courseList = [
          "Computer Science and Engineering",
          "Electronics and Communication Engineering",
          "Electrical and Electronics Engineering",
          "Mechanical Engineering",
          "Civil Engineering",
          "Chemical Engineering"
        ];
        _joiningYearList = ["2022", "2023", "2024", "2025"];
        _completionYearList = ["2026", "2027", "2028", "2029"];
      } else if (val == 'M.E.') {
        _courseList = [
          "Computer Science and Engineering",
          "Artificial Intelligence & Machine Learning",
          "Embedded System",
          "Biotechnology",
          "Information Technology",
          "Automobile Engineering"
        ];
        _joiningYearList = ["2024", "2025"];
        _completionYearList = ["2026", "2027"];
      } else if (val == 'M.Sc - Integrated') {
        _courseList = [
          "Software Systems",
          "Data Science",
          "Decision and Computing Science",
          "Artificial Intelligence and Machine Learning",
        ];
        _joiningYearList = ["2021", "2022", "2023", "2024", "2025"];
        _completionYearList = ["2026", "2027", "2028", "2029", "2030"];
      } else if (val == 'MBA') {
        _courseList = [
          "Finance",
          "Marketing",
          "HR",
          "Business Analytics",
          "Operations"
        ];
        _joiningYearList = ["2024", "2025"];
        _completionYearList = ["2026", "2027"];
      } else if (val == 'MCA') {
        _courseList = [
          "Artificial Intelligence",
          "Software Engineering",
          "Data Science",
          "Cyber Security",
          "Data Analytics"
        ];
        _joiningYearList = ["2024", "2025"];
        _completionYearList = ["2026", "2027"];
      }
      _courseName = '';
      _yearOfJoining = '';
      _yearOfCompletion = '';
    } else if (which == 'courseName') {
      _courseName = val;
    } else if (which == 'yearOfJoining') {
      _yearOfJoining = val;
    } else if (which == 'yearOfCompletion') {
      _yearOfCompletion = val;
    }
    if (x == 1) {
      if (ref.watch(regNumController).isEdit) {
        await ref.read(regNumController).editedUpdate("Education Details");
      }
    }
    notifyListeners();
  }

  clearText() {
    _collegeName = '';
    _degreeName = '';
    _yearOfJoining = '';
    _yearOfCompletion = '';
    _courseName = '';
    notifyListeners();
  }

  editValueUpdate(val, ref) async {
    await valueUpdate("collegeName", val['collegeName'] ?? '');
    await valueUpdate("degreeName", val['degree'] ?? '');
    await valueUpdate("courseName", val['course'] ?? '');
    await valueUpdate("yearOfJoining", val['yearOfJoining'] ?? '');
    await valueUpdate("yearOfCompletion", val['yearOfCompletion'] ?? '');
    // await valueUpdate("collegeName", val['collegeName'] ?? '');
    // await valueUpdate("degreeName", val['degree'] ?? '');
    // await valueUpdate("courseName", val['course'] ?? '');
    // await valueUpdate("yearOfJoining", val['yearOfJoining'] ?? '');
    // await valueUpdate("yearOfCompletion", val['yearOfCompletion'] ?? '');

    _data = {
      'collegeName': _collegeName,
      'degree': _degreeName,
      'yearOfJoining': _yearOfJoining,
      'yearOfCompletion': _yearOfCompletion,
      'course': _courseName,
    };
    notifyListeners();
  }

  Map<String, dynamic> get data => _data;
  String get collegeName => _collegeName;
  String get degreeName => _degreeName;
  String get courseName => _courseName;
  String get yearOfJoining => _yearOfJoining;
  String get yearOfCompletion => _yearOfCompletion;
  List get courseList => _courseList;
  List get joiningYearList => _joiningYearList;
  List get completionYearList => _completionYearList;
  List get degreeList => _degreeList;
}
