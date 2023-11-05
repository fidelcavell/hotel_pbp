import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hotel_pbp/utils/logging_utils.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final CameraController cameraController;

  const DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.cameraController})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

mixin CameraController {
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File? fileResult;

  @override
  void initState() {
    fileResult = File(widget.imagePath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoggingUtils.LogStartFunction ("Build DisplayPictureScreen");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the Picture'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          widget.cameraController.resumePreview();
          return true;
        },
        
        child: Image.file(fileResult!),
      ),
    );
  }
}
