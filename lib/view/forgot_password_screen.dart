import 'package:flutter/material.dart';
import 'package:hotel_pbp/components/form_component.dart';
import 'package:hotel_pbp/entity/user.dart';
import 'package:hotel_pbp/view/login_view.dart';
import 'package:hotel_pbp/client/user_client.dart';
import 'package:hotel_pbp/entity/user.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conpasswordController = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //confirm username
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
                return null;
              },
                  controller: usernameController,
                  hintTxt: 'Username',
                  helperTxt: 'Inputkan username yang sudah terdaftar',
                  iconData: Icons.person),

              //confirm email
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                return null;
              },
                  controller: emailController,
                  hintTxt: 'Email',
                  helperTxt: 'inputkan email yang telah terdaftar',
                  iconData: Icons.email_outlined),

              //confirm new password
              inputForm(
                (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
                controller: passwordController,
                hintTxt: 'Password',
                helperTxt: 'Inputkan password',
                iconData: Icons.password,
                togglePassword: GestureDetector(
                  onTap: passwordVisibility,
                  child: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility),
                ),
              ),

              //re-confirm new password
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Password tidak boleh kosong';
                } else if (p0 != passwordController.text) {
                  return 'password tidak sama!!!';
                }
                return null;
              },
                  controller: conpasswordController,
                  hintTxt: 'Password',
                  helperTxt: 'Inputkan lagi password',
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //bagian yang error
                        final List<User> users = await UserClient.fetchAll();
                        for (User user in users) {
                          if (user.username == usernameController.text &&
                              user.email == emailController.text) {

                            //

                            //

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginView()));
                          }
                          return;
                        }
                      }
                    },
                    child: const Text('Change Password'),
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

  void passwordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
