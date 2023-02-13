import 'package:client/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/elevated_button.dart';
import 'package:client/widgets/input_field.dart';
import 'package:client/colors.dart';
import 'home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                hint: "Enter your password",
                obscure: true,
                left: 18,
                right: 18,
                top: 9,
                bottom: 18),
            const Center(
                child: NavigatingElevatedButton(
                    string: "Sign in",
                    location: HomeScreen(),
                    radius: 12,
                    top: 18,
                    bottom: 18)),
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
