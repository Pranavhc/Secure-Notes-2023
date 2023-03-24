import 'package:client/screens/home_screen.dart';
import 'package:client/screens/note_screen.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:client/screens/signup_screen.dart';
import 'package:client/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoutes =
    RouteMap(onUnknownRoute: (_) => const Redirect('/'), routes: {
  '/': (route) => const MaterialPage(child: WelcomeScreen()),
  '/sign-up': (route) => const MaterialPage(child: SignUpScreen()),
  '/sign-in': (route) => const MaterialPage(child: SignInScreen()),
});

final loggedInRoutes =
    RouteMap(onUnknownRoute: (_) => const Redirect('/'), routes: {
  '/': (route) => const MaterialPage(child: HomeScreen()),
  '/home': (route) => const MaterialPage(child: HomeScreen()),
  '/note/:id': (route) =>
      MaterialPage(child: NoteScreen(id: route.pathParameters['id']!)),
});
