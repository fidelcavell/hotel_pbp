import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hotel_pbp/components/form_component.dart';
import 'package:hotel_pbp/login_view.dart';

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
  String? _gender;
  bool? checkbox1 = false;
  bool? checkbox2 = false;

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
                  inputForm(((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Email Tidak Boleh Kosong';
                    }
                    if (!p0.contains('@')) {
                      return 'Email harus menggunakan @';
                    }
                    return null;
                  }),
                      controller: emailController,
                      hintTxt: "Email",
                      helperTxt: "",
                      iconData: Icons.email),
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
                      password: true),
                  inputForm(((p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Nomor telepon tidak Boleh kosong';
                    }
                    return null;
                  }),
                      controller: notelpController,
                      hintTxt: "No Telp",
                      helperTxt: "",
                      iconData: Icons.phone_android),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: dateController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Birth Date',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? datePicker = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                          );
                          if (datePicker != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(datePicker);
                            setState(() {
                              dateController.text = formattedDate.toString();
                            });
                          } else {
                            // ????
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 'Male',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            const Text('Male'),
                          ],
                        ),
                        const SizedBox(width: 40),
                        Row(
                          children: [
                            Radio(
                              value: 'Female',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            const Text('Female'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: checkbox1,
                              onChanged: (value) {
                                setState(() {
                                  checkbox1 = value;
                                });
                              },
                            ),
                            const Text('Travel'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: checkbox2,
                              onChanged: (value) {
                                setState(() {
                                  checkbox2 = value;
                                });
                              },
                            ),
                            const Text('Business'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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
                      }
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
