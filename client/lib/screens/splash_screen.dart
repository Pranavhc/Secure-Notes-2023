import 'package:client/model/error_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScrenn extends ConsumerStatefulWidget {
  const SplashScrenn({super.key});

  @override
  ConsumerState<SplashScrenn> createState() => _SplashScrennState();
}

class _SplashScrennState extends ConsumerState<SplashScrenn> {
  ErrorModel? errorModel;

  @override
  void initState() {
    super.initState();
    getUserData();
    Future.delayed(const Duration(seconds: 3)).then((value) => nextScreen());
  }

  void getUserData() async {
    errorModel = await ref.read(authRepositoryProvider).getUserData();

    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update((state) => errorModel!.data);
    }
  }

  void nextScreen() {
    final user = ref.watch(userProvider);
    print("user 1 - ${user.toString()}"); // remove this later
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                user != null ? const HomeScreen() : const WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/google-logo.png")],
        ),
      ),
    );
  }
}
