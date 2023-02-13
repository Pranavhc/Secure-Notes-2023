import 'package:client/colors.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:client/widgets/elevated_button.dart';
import 'package:client/widgets/input_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "Sign Up",
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
                  "create an account and get started now!",
                  style: TextStyle(
                    color: kFairTextSecondary,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Name",
                style: TextStyle(
                  color: kFairText,
                  fontSize: 16,
                ),
              ),
            ),
            const InputField(
                hint: "Enter your name",
                obscure: false,
                left: 18,
                right: 18,
                top: 9,
                bottom: 18),
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
            const InputField(
                hint: "Enter your email",
                obscure: false,
                left: 18,
                right: 18,
                top: 9,
                bottom: 18),
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
            const InputField(
                hint: "Create a password",
                obscure: true,
                left: 18,
                right: 18,
                top: 9,
                bottom: 18),
            const Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Confirm Password",
                style: TextStyle(
                  color: kFairText,
                  fontSize: 16,
                ),
              ),
            ),
            const InputField(
                hint: "Confirm the password",
                obscure: true,
                left: 18,
                right: 18,
                top: 9,
                bottom: 18),
            const Center(
                child: NavigatingElevatedButton(
                    string: "Sign up",
                    location: HomeScreen(),
                    radius: 12,
                    top: 18,
                    bottom: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ",
                    style: TextStyle(
                      color: kFairTextSecondary,
                      fontSize: 14,
                    )),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen())),
                  child: const Text("Sign in",
                      style: TextStyle(
                        color: kFairText,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
