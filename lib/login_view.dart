import 'package:flutter/material.dart';

import 'package:hotel_pbp/components/form_component.dart';
import 'package:hotel_pbp/main.dart';
import 'package:hotel_pbp/register_view.dart';
import 'package:hotel_pbp/home_grid.dart';

class LoginView extends StatefulWidget {
  const LoginView({this.data, super.key});

  final Map? data;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    controller: passwordController,
                    obscureText: !_showPassword,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: passwordVisibility,
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        }
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Row contain login's button and Register's button :
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
                            MaterialPageRoute(
                                builder: (_) => const HomeGridView()),
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
        builder: (_) => const RegisterView(), //register
      ),
    );
  }

  void passwordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void initState() {
    _showPassword = false;
  }
}
