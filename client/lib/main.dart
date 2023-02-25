import 'package:client/widgets/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Secure Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate:
          RoutemasterDelegate(routesBuilder: (context) => loggedOutRoute),
      routeInformationParser: const RoutemasterParser(),
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

