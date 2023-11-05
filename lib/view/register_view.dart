import 'package:flutter/material.dart';
import 'package:hotel_pbp/components/form_component.dart';
import 'package:hotel_pbp/view/login_view.dart';
import 'package:hotel_pbp/models/user_model.dart';
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
  TextEditingController noTelpController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  String? _gender = 'L';

  bool _isEmailAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 61, 49),
        title: const Text('Registration'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Username',
                        border: OutlineInputBorder()),
                    validator: (value) =>
                        value == '' ? 'Please enter your Username' : null,
                  ),
                  const SizedBox(height: 18.0),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        border: OutlineInputBorder()),
                    onChanged: (value) async {
                      final user = await UserRepo.getUserByEmail(value);
                      _isEmailAvailable = user is User ? false : true;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Tidak Boleh Kosong';
                      }
                      if (!value.contains('@')) {
                        return 'Email harus menggunakan @';
                      }
                      if (!_isEmailAvailable) {
                        return 'Email sudah digunakan';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18.0),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        hintText: 'Password',
                        border: OutlineInputBorder()),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 5) {
                        return 'Password minimal 5 digit';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18.0),
                  TextFormField(
                    controller: noTelpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Phone',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor telepon tidak Boleh kosong';
                      }
                      if (value.length < 10) {
                        return 'Nomor telepon minimal 10 digit';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Pria',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                          const Text('Laki-laki'),
                        ],
                      ),
                      const SizedBox(width: 15.0),
                      Row(
                        children: [
                          Radio(
                              value: 'Wanita',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              }),
                          const Text('Perempuan'),
                        ],
                      ),
                    ],
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
                                noTelpController.text);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
