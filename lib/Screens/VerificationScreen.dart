import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pequod/Screens/VerificationPreviewScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  late final List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initCamera();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    await onNewCameraSelected(_cameras.first);
  }

  @override
  void dispose() {
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<XFile?> capturePhoto() async {
    final CameraController? cameraController = _controller;
    if (cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      await cameraController.setFlashMode(FlashMode.off);
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  void _onTakePhotoPressed() async {
    final navigator = Navigator.of(context);
    final xFile = await capturePhoto();
    if (xFile != null) {
      if (xFile.path.isNotEmpty) {
        navigator.push(
          MaterialPageRoute(
            builder: (context) => VerificationPreviewScreen(imagePath: xFile.path),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: false,
          title: ClimateChangeTextWidget("Verify your Habit"),
        ),
        body: _isCameraInitialized
            ? Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(_controller!),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: _onTakePhotoPressed,
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  Future<void> onNewCameraSelected(CameraDescription description) async {
    final previousCameraController = _controller;

    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      description,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      debugPrint('Error initializing camera: $e');
    }
    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = _controller!.value.isInitialized;
      });
    }
  }
}

