import 'package:aadhaar_flutter/pages/Create_Edit/Address_Details_Page/addr_details_screen.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coreDetailsController =
    ChangeNotifierProvider<CoreDetailsProvider>((ref) => CoreDetailsProvider());
final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _middleNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _dateController = TextEditingController();
final TextEditingController _fatherNameController = TextEditingController();
final TextEditingController _motherNameController = TextEditingController();
final TextEditingController _placeOfBirthController = TextEditingController();
final TextEditingController _nationalityController = TextEditingController();

class CoreDetailsProvider extends ChangeNotifier {
  String _gender = '';
  Map<String, dynamic> _data = {};

  Future<void> selectDate(BuildContext context, ref) async {
    DateTime today = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formatted = "${picked.day}/${picked.month}/${picked.year}";
      _dateController.text = formatted;
    }
    if (ref.watch(regNumController).isEdit) {
      await ref.read(regNumController).editedUpdate("DOB");
    }
    notifyListeners();
  }

  sendData(context, ref) async {
    _data = {
      'firstName': _firstNameController.text,
      'middleName': _middleNameController.text,
      'lastName': _lastNameController.text,
      'father': _fatherNameController.text,
      'mother': _motherNameController.text,
      'gender': _gender,
      'dob': _dateController.text,
      'placeOfBirth': _placeOfBirthController.text,
      'nationality': _nationalityController.text,
    };
    notifyListeners();
    EasyLoading.dismiss();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddrDetailsScreen(),
      ),
    );
    // try {
    //   final response = await Dio().post(
    //     '$STUDENT_API/name',
    //     data: {
    //       'regNumber': ref.watch(regNumController).regNumTextController.text,
    //       'nameDetails': {
    //         'firstName': _firstNameController.text,
    //         'middleName': _middleNameController.text,
    //         'lastName': _lastNameController.text,
    //         'father': _fatherNameController.text,
    //         'mother': _motherNameController.text,
    //         'gender': _gender,
    //         'dob': _dateController.text,
    //         'placeOfBirth': _placeOfBirthController.text,
    //         'nationality': _nationalityController.text,
    //       },
    //     },
    //   );
    //   log(response.toString());
    //   if (response.statusCode == 200) {
    //     EasyLoading.dismiss();
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const AddrDetailsScreen(),
    //       ),
    //     );
    //   } else {
    //     EasyLoading.dismiss();
    //     EasyLoading.showError('Failed. Please Retry');
    //   }
    // } catch (e) {
    //   log(e.toString());
    //   EasyLoading.dismiss();
    //   EasyLoading.showError('Failed. Please Retry');
    // }
  }

  valueUpdate(ref, [val, which]) async {
    if (which == 'gender') {
      _gender = val;
    }
    if (ref.watch(regNumController).isEdit) {
      await ref.read(regNumController).editedUpdate("Name Details");
      
    }

    notifyListeners();
  }

  editValueUpdate(val) {
    _firstNameController.text = val['firstName'] ?? '';
    _middleNameController.text = val['middleName'] ?? '';
    _lastNameController.text = val['lastName'] ?? '';
    _fatherNameController.text = val['father'] ?? '';
    _motherNameController.text = val['mother'] ?? '';
    _gender = val['gender'] ?? 'Male';
    _dateController.text = val['dob'] ?? '';
    _placeOfBirthController.text = val['placeOfBirth'] ?? '';
    _nationalityController.text = val['nationality'] ?? '';
    notifyListeners();
  }

  clearText() {
    _firstNameController.clear();
    _middleNameController.clear();
    _lastNameController.clear();
    _dateController.clear();
    _fatherNameController.clear();
    _motherNameController.clear();
    _placeOfBirthController.clear();
    _nationalityController.clear();
    _gender = '';
    notifyListeners();
  }

  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get middleNameController => _middleNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get fatherNameController => _fatherNameController;
  TextEditingController get motherNameController => _motherNameController;
  TextEditingController get placeOfBirthController => _placeOfBirthController;
  TextEditingController get nationalityController => _nationalityController;
  TextEditingController get dateController => _dateController;
  String get gender => _gender;
  Map<String, dynamic> get data => _data;
}
