import 'package:client/colors.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:client/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cPassword = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    cPassword.dispose();
    super.dispose();
  }

  void registerWithEmail(WidgetRef ref, BuildContext context) async {
    final sMessanger = ScaffoldMessenger.of(context);
    final navigator = Routemaster.of(context);
    final errorModel = await ref
        .read(authRepositoryProvider)
        .registerWithEmail(name.text, email.text, password.text);
    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.push('/home');
    } else {
      sMessanger.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

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
            InputField(
                hint: "Enter your name",
                controller: name,
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
            InputField(
                hint: "Enter your email",
                controller: email,
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
            InputField(
                hint: "Create a password",
                controller: password,
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
            InputField(
              hint: "Confirm the password",
              controller: cPassword,
              obscure: true,
              left: 18,
              right: 18,
              top: 9,
              bottom: 18,
            ),
            Center(
              child: InkWell(
                onTap: () => registerWithEmail(ref, context),
                child: const Text("Sign up",
                    style: TextStyle(
                      color: kFairText,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ",
                    style: TextStyle(
                      color: kFairTextSecondary,
                      fontSize: 14,
                    )),
                InkWell(
                  // onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const SignInScreen())),
                  onTap: () => Routemaster.of(context).push('/sign-in'),
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
