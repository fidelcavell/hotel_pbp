import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hotel_pbp/components/text_box.dart';
import 'package:hotel_pbp/client/user_client.dart';
import 'package:hotel_pbp/entity/user.dart';
import 'package:hotel_pbp/view/login_view.dart';

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
  final ImagePicker _imagePicker = ImagePicker();

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
        backgroundColor: const Color.fromARGB(255, 230, 96, 81),
        foregroundColor: Colors.white,
        title: const Center(
          child: Text('Profile'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginView(),
                ),
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView(
        children: [
          //profile pic
          const SizedBox(height: 20.0),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.camera), // Camera icon
                      title: const Text('Take a Photo'),
                      onTap: () async {
                        Navigator.pop(context);
                        final image = await _controller.takePicture();

                        // Update the profile picture in the database:
                        // SQLUserController.updateProfilePictureById(
                        //   currentUserID,
                        //   await convertImageToBase64(File(image.path)),
                        // );
                        setState(() {
                          _profilePic = File(image.path);
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_library), // Gallery icon
                      title: const Text('Choose from Gallery'),
                      onTap: () async {
                        Navigator.pop(context);
                        final pickedFile = await _imagePicker.pickImage(
                            source: ImageSource.gallery);

                        if (pickedFile != null) {
                          final image = File(pickedFile.path);

                          // Update the profile picture in the database:
                          // SQLUserController.updateProfilePictureById(
                          //   currentUserID,
                          //   await convertImageToBase64(image),
                          // );
                          setState(() {
                            _profilePic = image;
                          });
                        }
                      },
                    ),
                  ],
                ),
              );
            },
            child: CircleAvatar(
              radius: 96,
              backgroundImage: _profilePic != null
                  ? FileImage(_profilePic!)
                  : const AssetImage('assets/default-avatar.png')
                      as ImageProvider<Object>?,
            ),
          ),

          const SizedBox(height: 50),
          //details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Data diri',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //email
                TextBox(
                  text: _currentUser?.username ?? 'User.username',
                  sectionName: 'Username',
                  onPressed: () => editField('Username'),
                ),
                //email
                TextBox(
                  text: _currentUser?.email ?? 'user@gmail.com',
                  sectionName: 'Email',
                  onPressed: () => editField('Email'),
                ),
                //password

                //gender
                TextBox(
                  text: _currentUser?.gender ?? 'user.gender',
                  sectionName: 'Gender',
                  onPressed: () => editField('Gender'),
                ),

                //notelp
                TextBox(
                  text:
                      _currentUser?.nomorTelepon.toString() ?? 'user.numPhone',
                  sectionName: 'Nomor Telepon',
                  onPressed: () => editField('Nomor Telepon'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                case 'Nomor Telepon':
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
