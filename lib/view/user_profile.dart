import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hotel_pbp/components/text_box.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late CameraController _controller;
  File? _profilePic;

  @override
  void initState() {
    initCam();
    super.initState();
  }

  void initCam() async {
    final cameras = await availableCameras();
    for (final camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        _controller = CameraController(camera, ResolutionPreset.medium);
      }
    }
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 175, 61, 49),
          title: const Center(
            child: Text('Profile'),
          ),
        ),
        body: ListView(
          children: [
            //progile pic
            TextButton(
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          margin: const EdgeInsets.all(24),
                          child: Stack(
                            children: [
                              CameraPreview(_controller),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    final image =
                                        await _controller.takePicture();
                                    setState(() {
                                      _profilePic = File(image.path);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.camera_alt),
                                ),
                              ),
                            ],
                          ),
                        ));
              },
              child: CircleAvatar(
                radius: 96,
                backgroundImage: _profilePic != null
                    ? FileImage(_profilePic!)
                    : const AssetImage('assets/default-avatar.png')
                        as ImageProvider<Object>?,
              ),
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 50),
            //details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Data diri',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            //email
            TextBox(
              text: 'username current user',
              sectionName: 'Username',
              onPressed: () => editField('Username'),
            ),
            //email
            TextBox(
              text: 'email@user',
              sectionName: 'Email',
              onPressed: () => editField('Email'),
            ),
            //password

            //gender
            TextBox(
              text: 'Gender@user',
              sectionName: 'Gender',
              onPressed: () => editField('Gender'),
            ),

            //notelp
            TextBox(
              text: 'notelp@user',
              sectionName: 'noTelp',
              onPressed: () => editField('noTelp'),
            ),
          ],
        ));
  }

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Edit$field"),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //button cancel
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),

          //button save
          TextButton(
            child: const Text('Save'),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );
  }
}
