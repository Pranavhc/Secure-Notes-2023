// import 'package:flutter/cupertino.dart';
import 'package:client/colors.dart';
import 'package:client/widgets/elevated_button.dart';
import 'package:client/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackground,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 12),
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
            Padding(
              padding: EdgeInsets.only(bottom: 60),
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
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Name",
                style: TextStyle(
                  color: kFairText,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 18),
                child: InputField(
                  hint: "Enter your name",
                  obscure: false,
                )),
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Email",
                style: TextStyle(
                  color: kFairText,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 18),
                child: InputField(
                  hint: "Enter your email",
                  obscure: false,
                )),
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Password",
                style: TextStyle(
                  color: kFairText,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 18),
                child: InputField(
                  hint: "Create a password",
                  obscure: true,
                )),
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Confirm Password",
                style: TextStyle(
                  color: kFairText,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 18),
                child: InputField(
                  hint: "Confirm the password",
                  obscure: true,
                )),
            Padding(
                padding: EdgeInsets.only(top: 18, bottom: 18),
                child:
                    Center(child: NavigatingElevatedButton(string: "Sign up"))),
          ],
        ));
  }
}
