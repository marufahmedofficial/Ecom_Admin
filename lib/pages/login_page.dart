
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../auth/authservice.dart';
import 'launcher_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errMsg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email Address'
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Provide a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _passwordController,
                  //obscureText: true,
                  decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password(at least 6 characters)'
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Provide a valid password';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _authenticate,
                child: const Text('Login as Admin'),
              ),
              Row(
                children: [
                  const Text('Forgot password', style: TextStyle(fontSize: 18, color: Colors.red),),
                  TextButton(
                    onPressed: () {
                      AuthService.forgotPassword();
                    },
                    child: const Text('Click Here'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_errMsg, style: const TextStyle(fontSize: 18, color: Colors.red),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _authenticate() async {
    if(_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait', dismissOnTap: false);
      final email = _emailController.text;
      final password = _passwordController.text;
      try {
        final status = await AuthService.login(email, password);
        EasyLoading.dismiss();
        if(status) {
          if(mounted) {
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          }
        } else {
          await AuthService.logout();
          setState(() {
            _errMsg = 'This email address is not registered as Admin.';
          });
        }

      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        setState(() {
          _errMsg = error.message!;
        });
      }
    }
  }
}