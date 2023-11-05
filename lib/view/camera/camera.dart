import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hotel_pbp/utils/logging_utils.dart';
import 'package:hotel_pbp/view/camera/display_picture.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  Future<void>? _initializeCameraFuture;
  late CameraController _cameraController;

  var count = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    LoggingUtils.LogStartFunction("initialize camera".toUpperCase());
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    _initializeCameraFuture = _cameraController.initialize();
    if (mounted) {
      setState(() {
        LoggingUtils.LogEndFunction("success initialize camera".toUpperCase());
      });
    }
  }

  @override
  void dispose() {
    LoggingUtils.LogStartFunction("dispose CameraView".toUpperCase());
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _cameraController == null

    if (_initializeCameraFuture == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Picture'),
      ),
      body: FutureBuilder<void>(
        future: _initializeCameraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await previewImageResult(),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Future<DisplayPictureScreen?> previewImageResult() async {
    String activity = 'PREVIEW IMAGE RESULT';
    LoggingUtils.LogStartFunction(activity);
    try {
      await _initializeCameraFuture;
      final image = await _cameraController.takePicture();
      if (!mounted) return null;

      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        _cameraController.pausePreview();
        LoggingUtils.LogDebugValue(
            "get image on previewImageResult".toUpperCase(),
            "image path: ${image.path}");
        return DisplayPictureScreen(
            imagePath: image.path, cameraController: _cameraController);
      }));
    } catch (e) {
      LoggingUtils.LogError(activity, e.toString());
      return null;
    }
    return null;
  }
}
