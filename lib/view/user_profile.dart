import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hotel_pbp/components/text_box.dart';
import 'package:hotel_pbp/client/user_client.dart';
import 'package:hotel_pbp/entity/user.dart';

class UserProfile extends StatefulWidget {
  UserProfile({required this.id, super.key});
  int id;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late CameraController _controller;
  User? _currentUser;
  File? _profilePic;

  @override
  void initState() {
    initCam();
    initUser();
    super.initState();
  }

  void initUser() async {
    final u = await UserClient.find(widget.id);
    setState(() {
      _currentUser = u;
    });
    if (u.profilePicture != null) {
      final f = await convertBase64ToImage(u.profilePicture!);
      setState(() {
        _profilePic = f;
      });
    }
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

  // Convert Image to Base64 String
  Future<String> convertImageToBase64(File image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  // Convert Base64 String to Image
  Future<File> convertBase64ToImage(String base64Image) async {
    final bytes = base64Decode(base64Image);
    final directory = Directory.systemTemp;
    final file =
        File('${directory.path}/${DateTime.now().toUtc().toString()}.jpg');
    await file.writeAsBytes(bytes, flush: true);

    return file;
  }

  // Dispose Camera Controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

                                    // Bagian Update imagePath di database :
                                    // SQLUserController.updateProfilePictureById(
                                    //     currentUserID,
                                    //     await convertImageToBase64(
                                    //         File(image.path)));
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
              text: _currentUser?.username ?? 'Username@user',
              sectionName: 'Username',
              onPressed: () => editField('Username'),
            ),
            //email
            TextBox(
              text: _currentUser?.email ?? 'Email@user',
              sectionName: 'Email',
              onPressed: () => editField('Email'),
            ),
            //password

            //gender
            TextBox(
              text: _currentUser?.gender ?? 'Gender@user',
              sectionName: 'Gender',
              onPressed: () => editField('Gender'),
            ),

            //notelp
            TextBox(
              text: _currentUser?.nomorTelepon.toString() ?? 'NoTelp@user',
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
        title: Text("Edit $field"),
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
            onPressed: () async {
              final user = _currentUser;
              switch (field) {
                case 'Username':
                  user!.username = newValue;
                  break;
                case 'Email':
                  user!.email = newValue;
                  break;
                case 'Gender':
                  user!.gender = newValue;
                  break;
                case 'noTelp':
                  user!.nomorTelepon = int.parse(newValue);
                  break;
              }
              await UserClient.update(user!);
              initUser();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
