import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final finalController =
    ChangeNotifierProvider<FinalProvider>((ref) => FinalProvider());

class FinalProvider extends ChangeNotifier {
  String _uniqueId = '';
  String _imageData = '';

  valueUpdate(val) {
    _uniqueId = val;
    notifyListeners();
  }

  imageUpdate(val) {
    _imageData = val;
    notifyListeners();
  }

  clearText() {
    _uniqueId = '';
    notifyListeners();
  }

  String get uniqueId => _uniqueId;
  String get imageData => _imageData;
}
