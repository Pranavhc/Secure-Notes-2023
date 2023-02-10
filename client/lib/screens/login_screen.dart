import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton.icon(
            icon: Image.asset(
              "assets/google-logo.png",
              height: 20,
            ),
            label: const Text(
              'Sign in with Google',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: const Size(200, 50),
            ),
            onPressed: () {},
          ),
        )
      ],
    ));
  }
}
