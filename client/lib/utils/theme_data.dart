import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  splashColor: const Color(0xff161621),
  canvasColor: const Color(0xffF4F4F4),
  cardColor: Colors.white,
  colorScheme: const ColorScheme.light(
    background: Color(0xffF4F4F4),
    primary: Color(0xff161621),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  splashColor: const Color.fromARGB(255, 190, 190, 190),
  canvasColor: const Color(0xff161621),
  cardColor: const Color(0xff202030),
  colorScheme: const ColorScheme.dark(
    background: Color(0xff161621),
    primary: Colors.white,
  ),
);