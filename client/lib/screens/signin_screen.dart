import 'package:client/utils/colors.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/utils/settings.dart';
import 'package:client/widgets/elevated_button.dart';
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
  bool _isloading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void loginWithEmail(WidgetRef ref, BuildContext context) async {
    setState(() {
      _isloading = true;
    });
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
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 12),
            child: Center(
              child: Text(
                "Sign In",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
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
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              "Email",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
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
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              "Password",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
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
            child: CustomElevatedButton(
              isloading: _isloading,
              label: 'Sign in',
              onPressedFunc: () => loginWithEmail(ref, context),
              radius: 4,
              top: 18,
              bottom: 16,
              color1: Theme.of(context).colorScheme.primary,
              color2: Theme.of(context).colorScheme.primary,
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
                child: Text("Sign up",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton.small(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () => toggleTheme(ref),
          child: ref.watch(themeMode) == ThemeMode.dark
              ? Icon(Icons.nightlight,
                  color: Theme.of(context).colorScheme.background)
              : Icon(Icons.sunny,
                  color: Theme.of(context).colorScheme.background),
        ),
      ),
    );
  }
}
