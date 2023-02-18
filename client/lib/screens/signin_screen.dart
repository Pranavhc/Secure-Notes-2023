import 'dart:convert';
import 'package:client/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/input_field.dart';
import 'package:client/colors.dart';
import 'package:http/http.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void login() {
      try {
        http
            .post(Uri.parse("http://localhost:5000/api/v1/auth/login"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, String>{
                  'email': email.text,
                  'password': password.text
                }))
            .then((value) => {
                  print(value.body),
                  value.statusCode == 200
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()))
                      : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(value.body
                              .split(':')[1]
                              .replaceAll('/', '')
                              .replaceAll('}', '')
                              .replaceAll('"', ''))))
                });
      } catch (e) {
        const SnackBar(content: Text("Error"));
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackground,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 100, bottom: 12),
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: kFairText,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Center(
                child: Text(
                  "Hey, we met again. Let's go!",
                  style: TextStyle(
                    color: kFairTextSecondary,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            // - - - - - - - -

            const Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Email",
                style: TextStyle(
                  color: kFairText,
                  fontSize: 16,
                ),
              ),
            ),
            InputField(
                hint: "Enter your email",
                controller: email,
                keyboardType: TextInputType.emailAddress,
                obscure: false,
                left: 18,
                right: 18,
                top: 9,
                bottom: 18),

            // - - - - - - - -

            const Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Password",
                style: TextStyle(
                  color: kFairText,
                  fontSize: 16,
                ),
              ),
            ),
            InputField(
                hint: "Enter your password",
                controller: password,
                keyboardType: TextInputType.visiblePassword,
                obscure: true,
                left: 18,
                right: 18,
                top: 9,
                bottom: 18),

            // - - - - - - - -

            Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 18),
                  child: Container(
                      height: 45,
                      width: 200,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFC6C6C6), kFairText],
                          )),
                      child: ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        child: const Text("Sign in",
                            style: TextStyle(
                                color: kDarkText,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ))),
            ),

            // - - - - - - - -

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: kFairTextSecondary,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen())),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: kFairText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ));
  }
}
