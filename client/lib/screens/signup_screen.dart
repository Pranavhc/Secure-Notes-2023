import 'package:client/utils/colors.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/utils/theme_settings.dart';
import 'package:client/widgets/elevated_button.dart';
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
  bool _isloading = false;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    cPassword.dispose();
    super.dispose();
  }

  void registerWithEmail(WidgetRef ref, BuildContext context) async {
    setState(() {
      _isloading = true;
    });
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
                "Sign Up",
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
                "create an account and get started now!",
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
              "Name",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
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
              hint: "Create a password",
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
              onPressedFunc: () => registerWithEmail(ref, context),
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
              const Text("Already have an account? ",
                  style: TextStyle(
                    color: kFairTextSecondary,
                    fontSize: 14,
                  )),
              InkWell(
                // onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const SignInScreen())),
                onTap: () => Routemaster.of(context).push('/sign-in'),
                child: Text("Sign in",
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
