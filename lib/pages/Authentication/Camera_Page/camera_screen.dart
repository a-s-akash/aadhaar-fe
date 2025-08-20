import 'package:aadhaar_flutter/pages/Authentication/Camera_Page/camera_controller.dart';
import 'package:aadhaar_flutter/pages/Create_Edit/RegNumber_Page/regnum_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveCameraScreen extends ConsumerWidget {
  const LiveCameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capturedImage = ref.watch(liveCamController).capturedImage;
    String viewId = ref.watch(liveCamController).viewId;
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                capturedImage == null
                    ? const Text(
                        'Please take a photo of your face for biometric purpose',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    : const Text(
                        'Your face for biometric purpose',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                const SizedBox(height: 20),
                Container(
                  width: 640,
                  height: 500,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: capturedImage == null
                      ? HtmlElementView(viewType: viewId)
                      : Image.memory(
                          capturedImage,
                          width: 640,
                          height: 500,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(height: 24),
                capturedImage == null
                    ? IconButton(
                        style: ButtonStyle(
                            iconColor: MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: ref.read(liveCamController).captureFrame,
                        iconSize: 40,
                        icon: Icon(Icons.camera))
                    : Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              if (ref.watch(regNumController).isEdit) {
                                await ref
                                    .read(regNumController)
                                    .editedUpdate("Photo Updated");
                              }
                              await ref
                                  .read(liveCamController)
                                  .clearImage(true, ref);
                              // html.window.location.reload();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            label: const Text("Take Again"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () async {
                              await ref
                                  .read(liveCamController)
                                  .sendData(context, ref);
                              // html.window.location.reload();
                            },
                            label: const Text("Next"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
