import 'package:client/colors.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void loginWithEmail(WidgetRef ref, BuildContext context) async {
    final sMessanger = ScaffoldMessenger.of(context);
    final navigator = Routemaster.of(context);
    final errorModel = await ref
        .read(authRepositoryProvider)
        .loginWithEmail(email.text, password.text);
    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.replace("/home");
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
                  "Hey, Welcome buddy!",
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
                hint: "Enter a password",
                controller: password,
                obscure: true,
                left: 18,
                right: 18,
                top: 9,
                bottom: 18),
            Center(
              child:
                  //   NavigatingElevatedButton(
                  //       string: "Sign up",
                  //       location: HomeScreen(),
                  //       radius: 12,
                  //       top: 18,
                  //       bottom: 18),
                  // ),

                  InkWell(
                onTap: () => loginWithEmail(ref, context),
                child: const Text("Sign in",
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
                const Text("Don't have an account? ",
                    style: TextStyle(
                      color: kFairTextSecondary,
                      fontSize: 14,
                    )),
                InkWell(
                  // onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const SignUpScreen())),
                  onTap: () => Routemaster.of(context).push('/sign-up'),
                  child: const Text("Sign up",
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
