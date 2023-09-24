import 'package:flutter/material.dart'; 
import 'package:hotel_pbp/login_view.dart'; 
import 'package:hotel_pbp/register_view.dart';
import 'package:hotel_pbp/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = true;
  
  get suffixIcon => null;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;
    var list = [
              inputForm((p0) {
                if(p0 == null || p0.isEmpty) {
                  return "Username Tidak Boleh Kosong !";
                }
                return null;
              },
                  controller: usernameController,
                  hintTxt: "Username",
                  iconData: Icons.person),
              inputForm((p0) {
                if(p0 == null || p0.isEmpty) {
                  return "Password Tidak Boleh Kosong !";
                }
                return null;
              },
                  obscureText: _showPassword,
                  controller: passwordController,
                  hintTxt: "Password",
                  iconData: Icons.password),
                  suffixIcon: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: _showPassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        if(dataForm!['username'] == usernameController.text && dataForm['password'] == passwordController.text) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeView()));
                        }else{
                          showDialog(context: context, builder: (_) => AlertDialog(
                            title: const Text('Password salah'),
                            content: TextButton(
                              onPressed: () => pushRegister(context),
                              child: const Text ("Daftar disini !!")),
                            actions: <Widget> [
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),);
                        }
                      }
                    },
                    child: const Text('Login')),
                
                ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> formData = {};
                    formData['username'] = usernameController.text;
                    formData['password'] = passwordController.text;
                    pushRegister(context);
                  },
                  child: const Text('Daftar')),
                ],
              ),
            ];
    var children2 = list;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children2,
          ),
        ),
      ),
    );
  }
  void pushRegister(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterView(),),);
  }

  void _togglePasswordVisibility () {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}

