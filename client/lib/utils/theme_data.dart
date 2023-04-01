import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  splashColor: const Color(0xff161621),
  canvasColor: const Color(0xFFF8F8F8),
  cardColor: Colors.white,
  dialogBackgroundColor: const Color(0xFFF4F4F4),
  shadowColor: Colors.grey.shade300,
  colorScheme: const ColorScheme.light(
    background: Color(0xffF4F4F4),
    primary: Color(0xff161621),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  splashColor: const Color(0xFFBEBEBE),
  canvasColor: const Color(0xff161621),
  cardColor: const Color(0xff202030),
  dialogBackgroundColor: const Color(0xFF26263A),
  shadowColor: const Color(0xFF0A0A0F),
  colorScheme: const ColorScheme.dark(
    background: Color(0xff161621),
    primary: Colors.white,
  ),
);
