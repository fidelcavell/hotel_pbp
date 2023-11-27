import 'package:flutter/material.dart';

import 'package:hotel_pbp/components/form_component.dart';
import 'package:hotel_pbp/view/register_view.dart';
import 'package:hotel_pbp/view/main_screen.dart';
import 'package:hotel_pbp/client/user_client.dart';
import 'package:hotel_pbp/entity/user.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final List<User> users = await UserClient.fetchAll();
                        for (User user in users) {
                          if (user.username == usernameController.text &&
                              user.password == passwordController.text) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MainScreen(id: user.id)),
                            );
                            return;
                          }
                        }
                        
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
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
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

void showSnackBar(BuildContext context, String message, Color background) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: background,
      action: SnackBarAction(
        label: 'hide',
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ),
  );
}
