import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class SplashScrenn extends StatefulWidget {
  const SplashScrenn({super.key});

  @override
  State<SplashScrenn> createState() => _SplashScrennState();
}

class _SplashScrennState extends State<SplashScrenn> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Routemaster.of(context).replace('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/google-logo.png",
                height: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
