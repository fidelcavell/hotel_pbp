import 'package:flutter/material.dart';

import 'package:hotel_pbp/components/form_component.dart';
import 'package:hotel_pbp/view/register_view.dart';
import 'package:hotel_pbp/view/main_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({this.data, super.key});

  final Map? data;

  @override
  State<LoginView> createState() => _LoginViewState();
}

var themeMode = false;

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Username :
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
                return null;
              },
                  controller: usernameController,
                  hintTxt: 'Username',
                  helperTxt: 'Inputkan User yang telah didaftar',
                  iconData: Icons.person),
              // Password :
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
                return null;
              },
                  onChanged: (p0) {},
                  controller: passwordController,
                  obscureText: _showPassword,
                  hintTxt: 'Password',
                  helperTxt: 'Inputkan Password yang telah didaftar',
                  iconData: Icons.password,
                  togglePassword: GestureDetector(
                    onTap: passwordVisibility,
                    child: Icon(_showPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                  )),
              const SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Login button :
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (dataForm!['username'] == usernameController.text &&
                            dataForm['password'] == passwordController.text) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const  MainScreen()),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text('Password Salah'),
                                    content: TextButton(
                                      onPressed: () => pushRegister(context),
                                      child: const Text('Daftar disini !!'),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      Map<String, dynamic> formData = {};
                      formData['username'] = usernameController.text;
                      formData['password'] = passwordController.text;
                      pushRegister(context);
                    },
                    child: const Text('Belum punya akun?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // ga bisa ganti theme
        onPressed: () {
          setState(() {
            themeMode = !themeMode;
          });
        },
        child: Icon(themeMode ? Icons.nights_stay : Icons.wb_sunny),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterView(),
      ),
    );
  }

  void passwordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
