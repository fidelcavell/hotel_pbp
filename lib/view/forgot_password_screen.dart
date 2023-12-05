// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:hotel_pbp/entity/user.dart';
import 'package:hotel_pbp/view/login_view.dart';
import 'package:hotel_pbp/client/user_client.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conpasswordController = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: const Color.fromARGB(255, 226, 69, 51),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 44.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //confirm username
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Your Current Email',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is Required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: passwordVisibility,
                          child: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      prefixIcon: const Icon(Icons.password),
                      hintText: 'Your New Password',
                      border: const OutlineInputBorder()),
                  obscureText: _showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is Required';
                    }
                    if (value.length < 5) {
                      return 'Password minimal 5 digit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: conpasswordController,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: passwordVisibility,
                          child: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      prefixIcon: const Icon(Icons.password),
                      hintText: 'Re-Confirm New Password',
                      border: const OutlineInputBorder()),
                  obscureText: _showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is Required';
                    }
                    if (value.length < 5) {
                      return 'Password minimal 5 digit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //bagian yang fix
                      final List<User> users = await UserClient.fetchAll();
                      for (User user in users) {
                        if (user.email == emailController.text) {
                          User newData = User(
                            id: user.id,
                            username: user.username,
                            email: user.email,
                            password: passwordController.text,
                            gender: user.gender,
                            nomorTelepon: user.nomorTelepon,
                            origin: user.origin,
                            profilePicture: user.profilePicture,
                          );

                          try {
                            await UserClient.update(newData);

                            showSnackBar(context, 'Success', Colors.green);
                            Navigator.pop(context);
                          } catch (err) {
                            showSnackBar(context, err.toString(), Colors.red);
                            Navigator.pop(context);
                          }

                          return;
                        }
                      }
                      showSnackBar(
                          context, 'Data user tidak ditemukan', Colors.red);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 226, 69, 51),
                  ),
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void passwordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
