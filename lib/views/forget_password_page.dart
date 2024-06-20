import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hajj_app/services/auth_service.dart';
import 'package:hajj_app/services/user_service.dart';

class ResetPasswordPage extends StatefulWidget {
  static String id = 'ResetPasswordPage';

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  final AuthService _authService = AuthService();

  Future<void> resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      try {
        await _authService.sendPasswordResetEmail(_emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email sent')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Reset Password')),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextFormField(
  //               controller: _emailController,
  //               decoration: InputDecoration(labelText: 'Email'),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter your email';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             SizedBox(height: 20),
  //             _isProcessing
  //                 ? CircularProgressIndicator()
  //                 : ElevatedButton(
  //                     onPressed: resetPassword,
  //                     child: Text('Reset Password'),
  //                   ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'استعاده الرقم السرى',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ادخل البريد الالكترونى الخاص بك ',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  errorStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isProcessing
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: resetPassword,
                      child: const Text('ارسال البريد الالكترونى'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
