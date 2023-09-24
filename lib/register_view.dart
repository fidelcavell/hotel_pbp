import 'package:flutter/material.dart';
import 'package:hotel_pbp/component/form_component.dart';
import 'package:hotel_pbp/View/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();

  bool _obscurePassword =
      true; // Variabel untuk mengatur apakah password tersembunyi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  helperTxt: "Ucup Serucup",
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
                  helperTxt: "ucup@gmail.com",
                  iconData: Icons.email),
              TextFormField(
                controller: passwordController,
                obscureText:
                    _obscurePassword, // Menyembunyikan atau menampilkan password
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'xxxxxxx',
                  icon: Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
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
              inputForm(((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Nomor telepon tidak Boleh kosong';
                }
                return null;
              }),
                  controller: notelpController,
                  hintTxt: "No Telp",
                  helperTxt: "08216734894",
                  iconData: Icons.phone_android),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> formData = {};
                      formData['username'] = usernameController.text;
                      formData['password'] = passwordController.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginView(
                            data: formData,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Register'))
            ],
          ),
        ),
      ),
    );
  }
}

class inputForm extends StatelessWidget {
  final String? Function(String?) validator;
  final TextEditingController controller;
  final String hintTxt;
  final String helperTxt;
  final IconData iconData;

  inputForm(
    this.validator, {
    Key? key,
    required this.controller,
    required this.hintTxt,
    required this.helperTxt,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintTxt,
          hintText: helperTxt,
          icon: Icon(iconData),
        ),
        validator: validator,
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  final Map<String, dynamic> data;

  const LoginView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Username: ${data['username']}'),
            Text('Password: ${data['password']}'),
          ],
        ),
      ),
    );
  }
}
