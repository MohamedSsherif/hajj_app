// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hajj_app/constants.dart';
import 'package:hajj_app/helpers/show_snack_bar.dart';
import 'package:hajj_app/views/home_page.dart';
import 'package:hajj_app/views/register_page.dart';
import 'package:hajj_app/widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: "mohamed@gmail.com".dev);
    passwordController = TextEditingController(text: "12345678".dev);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        //resizeToAvoidBottomInset: false,
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const CircleAvatar(
                  radius: 100.0,
                  //child: Image.asset('images/Hajj.png'),
                  backgroundImage: AssetImage('assets/images/Hajj.png'),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Muslim',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          )),
                    ],
                  ),
                ),
                CustomFormTextField(
                    controller: emailController,
                    onChanged: (value) {
                      email = value;
                    },
                    labelText: 'Email'),
                CustomFormTextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  labelText: 'Password',
                ),
                CustomButton(
                  onTap: () async {
                    // FocusManager.instance.primaryFocus?.unfocus();
                    FocusScope.of(context).unfocus();

                    if (formKey.currentState!.validate() && emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

                        if (user.user != null) {
                          showSnackBar(context, 'success');
                          Navigator.pushReplacementNamed(context, HomePage.id);
                        } else {
                          showSnackBar(context, "Wrong credentials");
                        }
                      } on FirebaseAuthException catch (e) {
                        String error = "Error";
                        switch (e.code) {
                          case "network-request-failed":
                            error = "Timeout";
                            break;
                          case "user-not-found":
                            error = "USer not found";
                            break;
                          case "wrong-password":
                          case "invalid-credential":
                            error = "Invalid credentials";
                            break;

                          default:
                            error = "Something went worng!";
                        }

                        showSnackBar(context, error);
                      } on PlatformException catch (e) {
                        showSnackBar(context, e.toString());
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  text: 'Sign In',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?', style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Register.id);
                      },
                      child: const Text('Register', style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}

extension Dev on String {
  String? get dev {
    if (kDebugMode) {
      return this;
    } else {
      return null;
    }
  }
}
