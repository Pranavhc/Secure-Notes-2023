import 'package:client/colors.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:client/screens/signup_screen.dart';
import 'package:client/widgets/Infinite_carousel.dart';
import 'package:flutter/material.dart';
import '../widgets/elevated_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(height: 360, child: InfiniteCarouselWidget()),
              //
              Center(
                child: NavigatingElevatedButton(
                  imgpath: "assets/email-logo.png",
                  string: "Sign in with email",
                  location: SignInScreen(),
                  radius: 4,
                  bottom: 18,
                  width: 240,
                  color1: Color.fromARGB(255, 255, 158, 119),
                  color2: Color.fromARGB(255, 255, 122, 69),
                ),
              ),
              Center(
                child: NavigatingElevatedButton(
                  imgpath: "assets/email-logo.png",
                  string: "Sign up with email",
                  location: SignUpScreen(),
                  radius: 4,
                  bottom: 18,
                  width: 240,
                ),
              ),
              Center(
                child: NavigatingElevatedButton(
                  imgpath: "assets/google-logo.png",
                  string: "Sign in with google",
                  location: HomeScreen(),
                  radius: 4,
                  bottom: 18,
                  width: 240,
                  color1: Color.fromARGB(255, 175, 255, 212),
                  color2: Color.fromARGB(255, 90, 255, 167),
                ),
              )
            ]),
      ),
    );
  }
}
