import 'package:flutter/material.dart';

import 'package:hotel_pbp/components/form_component.dart';
import 'package:hotel_pbp/login_view.dart';
import 'package:hotel_pbp/repos/user_repo.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? _gender = 'L';
  bool? checkbox1 = false;
  bool? checkbox2 = false;

  bool _isEmailAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  inputForm((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Username Tidak Boleh Kosong';
                    }
                    if (p0.toLowerCase() == 'anjing') {
                      return "Tidak Boleh Menggunakan kata kasar";
                    }
                    return null;
                  },
                      controller: usernameController,
                      hintTxt: "Username",
                      helperTxt: "",
                      iconData: Icons.person),
                  inputForm(
                    ((p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Email Tidak Boleh Kosong';
                      }
                      if (!p0.contains('@')) {
                        return 'Email harus menggunakan @';
                      }
                      if (!_isEmailAvailable) {
                        return 'Email sudah digunakan!!!!!';
                      }
                      return null;
                    }),
                    controller: emailController,
                    hintTxt: "Email",
                    helperTxt: "",
                    iconData: Icons.email,
                    onChanged: (p0) {
                      UserRepo.getUserByEmail(p0).then((value) {
                        setState(() {
                          _isEmailAvailable = value.email == p0 ? false : true;
                        });
                      });
                    },
                  ),
                  inputForm(((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }

                    if (p0.length < 5) {
                      return 'Password minimal 5 digit';
                    }
                    return null;
                  }),
                      controller: passwordController,
                      hintTxt: 'Password',
                      helperTxt: '',
                      iconData: Icons.password,
                      obscureText: true),
                  inputForm(((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Nomor telepon tidak Boleh kosong';
                    }
                    if (p0.length < 10) {
                      return 'Nomor telepon minimal 10 digit';
                    }
                    return null;
                  }),
                      controller: notelpController,
                      hintTxt: "No Telp",
                      helperTxt: "",
                      iconData: Icons.phone_android),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'L',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value.toString();
                                });
                              },
                            ),
                            const Text('Laki-laki'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'P',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value.toString();
                                  });
                                }),
                            const Text('Perempuan'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              _gender!.isNotEmpty) {
                            await UserRepo.createUser(
                                usernameController.text,
                                emailController.text,
                                passwordController.text,
                                _gender!,
                                notelpController.text);
                            Map<String, dynamic> formData = {};
                            formData['username'] = usernameController.text;
                            formData['password'] = passwordController.text;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Information'),
                                content: const Text('Account has been created'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => LoginView(
                                            data: formData,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("Continue"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Warning'),
                                content: const Text('Failed to create Account'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("Retry"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
