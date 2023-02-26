import 'package:client/screens/home_screen.dart';
import 'package:client/screens/note_screen.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:client/screens/signup_screen.dart';
import 'package:client/screens/splash_screen.dart';
import 'package:client/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final allroutes = RouteMap(routes: {
  '/': (route) => const MaterialPage(child: SplashScrenn()),
  '/welcome': (route) => const MaterialPage(child: WelcomeScreen()),
  '/sign-up': (route) => const MaterialPage(child: SignUpScreen()),
  '/sign-in': (route) => const MaterialPage(child: SignInScreen()),
  '/home': (route) => const MaterialPage(child: HomeScreen()),
  '/note/:id': (route) =>
      MaterialPage(child: NoteScreen(id: route.pathParameters['id']!)),
});
