import 'package:client/screens/home_screen.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:client/screens/signup_screen.dart';
import 'package:client/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/sign-up': (context) => const SignUpScreen(),
        '/sign-in': (context) => const SignInScreen(),
        "/home": (context) => const HomeScreen()
      },
    );
  }
}
// ROUTES
// "/" - intro & login options
// "/sign-up" - Register
// "/sign-in" - Login
// "/home" - home screen (notes / notebooks, searchbar)
// "/note" - selected note from notes
// "/new" - new note/document
// "/settings" - settings, account

// TODO - bare minimum
// login with email       ✅
// Register with email 
// Home screen
// quill text editor

