// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:hotel_pbp/view/forgot_password_screen.dart';
import 'package:hotel_pbp/view/register_view.dart';
import 'package:hotel_pbp/view/main_screen.dart';
import 'package:hotel_pbp/client/user_client.dart';
import 'package:hotel_pbp/entity/user.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, this.userClient});

  final UserClient? userClient;

  @override
  State<LoginView> createState() => _LoginViewState();
}

var themeMode = false;

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      width: 300,
                      height: 300,
                    ),
                  ),
                  //* Email Input Field :
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextFormField(
                    key: const Key('Email'),
                    controller: emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Your Email',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is Required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  //* Password Input Field :
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextFormField(
                    key: const Key('Password'),
                    controller: passwordController,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: passwordVisibility,
                            child: Icon(_showPassword
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        prefixIcon: const Icon(Icons.password),
                        hintText: 'Your Password',
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
                  Center(
                    child: SizedBox(
                      width: 150,
                      key: const Key('loginButton'),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            // future delayed 2 seconds
                            // await Future.delayed(const Duration(seconds: 2));
                            final List<User> users =
                                await UserClient.fetchAll();
                            for (User user in users) {
                              if (user.email == emailController.text &&
                                  user.password == passwordController.text) {
                                showSnackBar(
                                    context, 'Berhasil Login', Colors.green);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MainScreen(id: user.id)),
                                );
                                setState(() {
                                  _isLoading = false;
                                });
                                return;
                              }
                            }
                            showSnackBar(context,
                                "Username atau Password salah", Colors.red);
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 226, 69, 51),
                          foregroundColor: Colors.white,
                        ),
                        child: _isLoading
                            ? Container(
                                padding: const EdgeInsets.all(5.0),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 5,
                                ),
                              )
                            : const Text('Login'),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: const Center(
                      child: Text(
                        'Or',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () {
                          Map<String, dynamic> formData = {};
                          formData['email'] = emailController.text;
                          formData['password'] = passwordController.text;
                          pushRegister(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 226, 69, 51),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 226, 69, 51),
                          ),
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 170,
                      child: TextButton(
                        onPressed: () {
                          Map<String, dynamic> formData = {};
                          formData['password'] = passwordController.text;
                          pushChangePassword(context);
                        },
                        child: const Text('Forget Password',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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

  void pushChangePassword(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ForgotPassword()));
  }
}

void showSnackBar(BuildContext context, String message, Color background) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
      backgroundColor: background,
      // action: SnackBarAction(
      //   label: 'hide',
      //   onPressed: scaffold.hideCurrentSnackBar,
      // ),
    ),
  );
}
