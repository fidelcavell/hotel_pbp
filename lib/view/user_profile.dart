import 'package:flutter/material.dart';
import 'package:hotel_pbp/components/text_box.dart';
import 'package:hotel_pbp/database/sql_user_controller.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile Page"),
          backgroundColor: Colors.cyan,
        ),
        body: ListView(
          children: [
            //progile pic
            const Icon(
              Icons.person,
              size: 72,
            ),

            const SizedBox(height: 10),
            //header
            // Text(
            //     // //tampil username user
            //     // textAlign: TextAlign.center,
            //     // style: TextStyle(color: Colors.grey[900]),
            //     ),
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
        title: Text("Edit" + field),
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
            onPressed: ()=> Navigator.pop(context),
            ),

          //button save
          TextButton(
            child: const Text('Save'),
            onPressed: ()=> Navigator.of(context).pop(newValue),
            ),
        ],
      ),
    );
  }
}
