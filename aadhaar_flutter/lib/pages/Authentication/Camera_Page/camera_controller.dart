import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:aadhaar_flutter/pages/Create_Edit/Contact_Details_Page/contact_details_screen.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:aadhaar_flutter/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final liveCamController =
    ChangeNotifierProvider<LiveCamProvider>((ref) => LiveCamProvider());

class LiveCamProvider extends ChangeNotifier {
  late html.VideoElement _videoElement;
  late html.CanvasElement _canvasElement;

  Uint8List? _capturedImage;
  String? _base64Json;
  String _viewId = 'camera-view';
  bool _cameraPermission = false;
  Map<String, dynamic> _data = {};

  LiveCamProvider() {
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _videoElement = html.VideoElement()
      ..autoplay = true
      ..width = 640
      ..height = 500
      ..style.objectFit = 'cover'
      ..style.border = 'none'
      ..style.overflow = 'hidden'
      ..style.maxWidth = '100%'
      ..style.maxHeight = '100%'
      ..style.transform = 'scaleX(-1)';

    final container = html.DivElement()
      ..id = 'camera-container-$_viewId' // optional unique ID
      ..append(_videoElement);

    // ✅ Register dynamic view type
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(_viewId, (int viewId) => container);

    try {
      EasyLoading.show(status: 'Connecting to Camera...');
      await html.window.navigator.mediaDevices!
          .getUserMedia({'video': true}).then((stream) {
        _videoElement.srcObject = stream;
        EasyLoading.dismiss();
        _cameraPermission = true;
        _canvasElement = html.CanvasElement(width: 640, height: 500);
      });
    } catch (_) {
      EasyLoading.showInfo(
          'Camera Permission Denied. Please allow camera access.');
    }

    notifyListeners();
  }

  sendData(context, ref) async {
    _data = {'photo': _base64Json};
    notifyListeners();

    EasyLoading.dismiss();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ContactDetailsScreen(),
        ));
    // try {
    //   Response response = await Dio().post(
    //     '$STUDENT_API/photo',
    //     data: {
    //       'regNumber': ref.watch(regNumController).regNumTextController.text,
    //       'photoDetails': {'photo': _base64Json}
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     clearImage();
    //     EasyLoading.dismiss();
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const ContactDetailsScreen(),
    //         ));
    //   } else {
    //     EasyLoading.dismiss();
    //     EasyLoading.showError('Failed. Please Retry');
    //   }
    // } catch (_) {
    //   EasyLoading.dismiss();
    //   EasyLoading.showError('Failed. Please Retry');
    // }
  }

  void captureFrame() {
    final context = _canvasElement.context2D;

    // Optional: clear canvas before drawing (not strictly necessary with scaling)
    context
      ..fillStyle = 'white'
      ..fillRect(0, 0, _canvasElement.width!, _canvasElement.height!);

    // ✅ Scale video to fully fill the canvas
    context.save();
    context.translate(
        _canvasElement.width!.toDouble(), 0); // Move to right edge
    context.scale(-1, 1); // Flip horizontally
    context.drawImageScaled(
      _videoElement,
      0,
      0,
      _canvasElement.width!,
      _canvasElement.height!,
    );
    context.restore();

    _canvasElement.toBlob().then((blob) {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(blob);
      reader.onLoadEnd.listen((event) {
        final bytes = reader.result as Uint8List;
        final base64 = base64Encode(bytes);

        _capturedImage = bytes;
        _base64Json = base64;

        _videoElement.srcObject?.getTracks().forEach((track) => track.stop());
        notifyListeners();
      });
    });
  }

  clearImage([bool resume = false, ref]) async {
    _capturedImage = null;
    _base64Json = null;
    _cameraPermission = false;
    _videoElement.srcObject
        ?.getTracks()
        .forEach((track) => track.stop()); // stop old stream
    if (resume) {
      _viewId = 'camera-view-${DateTime.now().millisecondsSinceEpoch}';
      await _initializeCamera();
    }
    notifyListeners();
  }

  editValueUpdate(val) async {
    await clearImage();
    _capturedImage = val['photo'] != null ? base64Decode(val['photo']) : null;
    _base64Json = val['photo'] ?? null;
    notifyListeners();
  }

  Uint8List? get capturedImage => _capturedImage;
  String? get base64Json => _base64Json;
  String get viewId => _viewId;
  bool get cameraPermission => _cameraPermission;
  Map<String, dynamic> get data => _data;
}
