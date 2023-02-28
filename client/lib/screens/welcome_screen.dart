import 'package:client/utils/colors.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:client/screens/signup_screen.dart';
import 'package:client/widgets/infinite_carousel.dart';
import 'package:flutter/material.dart';
import '../widgets/elevated_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void navigateTo(Widget location) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => location));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 360, child: InfiniteCarouselWidget()),
              //
              Center(
                child: CustomElevatedButton(
                  onPressedFunc: () => navigateTo(const SignInScreen()),
                  imgpath: "assets/email-logo.png",
                  label: "Sign in with email",
                  radius: 4,
                  top: 18,
                  bottom: 18,
                  width: 240,
                  color1: const Color.fromARGB(255, 153, 255, 231),
                  color2: const Color.fromARGB(255, 90, 208, 255),
                ),
              ),
              Center(
                child: CustomElevatedButton(
                  onPressedFunc: () => navigateTo(const SignUpScreen()),
                  imgpath: "assets/email-logo.png",
                  label: "Sign up with email",
                  radius: 4,
                  bottom: 18,
                  width: 240,
                  color2: const Color.fromARGB(255, 132, 255, 190),
                  color1: const Color.fromARGB(255, 90, 208, 255),
                ),
              ),
              Center(
                child: CustomElevatedButton(
                  onPressedFunc: () => navigateTo(const HomeScreen()),
                  imgpath: "assets/google-logo.png",
                  label: "Sign in with google",
                  radius: 4,
                  width: 240,
                  color2: const Color.fromARGB(255, 113, 255, 246),
                  color1: const Color.fromARGB(255, 90, 208, 255),
                ),
              )
            ]),
      ),
    );
  }
}
