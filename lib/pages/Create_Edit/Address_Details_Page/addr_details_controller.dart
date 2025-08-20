import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_screen.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/Educational_Details_Page/edu_details_screen.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addrDetailsController =
    ChangeNotifierProvider<AddrDetailsProvider>((ref) => AddrDetailsProvider());
final TextEditingController _residenceAddrTextController =
    TextEditingController();
final TextEditingController _permanentAddrTextController =
    TextEditingController();
final TextEditingController _countryTextController = TextEditingController();
final TextEditingController _stateTextController = TextEditingController();
final TextEditingController _districtTextController = TextEditingController();

class AddrDetailsProvider extends ChangeNotifier {
  bool _isSameAddr = false;
  Map<String, dynamic> _data = {};

  sendData(context, ref) async {
    _data = {
      'permanentAddress': _permanentAddrTextController.text,
      'currentAddress': _residenceAddrTextController.text,
      'district': _districtTextController.text,
      'state': _stateTextController.text,
      'country': _countryTextController.text
    };
    notifyListeners();

    EasyLoading.dismiss();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EduDetailsScreen(),
      ),
    );
    // try {
    // Response response = await Dio().post(
    //   '$STUDENT_API/address',
    //   data: {
    //     'regNumber': ref.watch(regNumController).regNumTextController.text,
    //     'addressDetails': {
    //       'permanentAddress': _permanentAddrTextController.text,
    //       'currentAddress': _residenceAddrTextController.text,
    //       'district': _districtTextController.text,
    //       'state': _stateTextController.text,
    //       'country': _countryTextController.text
    //     }
    //   },
    // );
    // if (response.statusCode == 200) {
    //     EasyLoading.dismiss();
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const EduDetailsScreen(),
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

  switchAddr(value) {
    _isSameAddr = value;
    _permanentAddrTextController.text = _residenceAddrTextController.text;
    notifyListeners();
  }

  valueUpdate(ref) async{
    notifyListeners();
     if (ref.watch(regNumController).isEdit) {
      await ref.read(regNumController).editedUpdate("Address Details");
    }
  }

  editValueUpdate(val) {
    _residenceAddrTextController.text = val['currentAddress'] ?? '';
    _permanentAddrTextController.text = val['permanentAddress'] ?? '';
    _countryTextController.text = val['country'] ?? '';
    _stateTextController.text = val['state'] ?? '';
    _districtTextController.text = val['district'] ?? '';
    notifyListeners();
  }

  clearText() {
    _residenceAddrTextController.clear();
    _permanentAddrTextController.clear();
    _countryTextController.clear();
    _stateTextController.clear();
    _districtTextController.clear();
    _isSameAddr = false;
    notifyListeners();
  }

  bool get isSameAddr => _isSameAddr;
  TextEditingController get residenceAddrTextController =>
      _residenceAddrTextController;
  TextEditingController get permanentAddrTextController =>
      _permanentAddrTextController;
  TextEditingController get countryTextController => _countryTextController;
  TextEditingController get stateTextController => _stateTextController;
  TextEditingController get districtTextController => _districtTextController;
  Map<String, dynamic> get data => _data;
}
