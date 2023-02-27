import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeMode = StateProvider((ref) => ThemeMode.dark);

final theme = Provider((ref) => _theme);
final darkTheme = Provider((ref) => _darkTheme);

const Color lightBackground = Color(0xfff0f0f0);
const Color darkForeground = Color(0xff232323);

// light
final _theme = ThemeData(
  brightness: Brightness.light,
  canvasColor: Colors.white,
  cardColor: lightBackground,
  colorScheme: const ColorScheme.light(
    background: lightBackground,
    primary: Colors.black,
  ),
);

//dark
final _darkTheme = ThemeData(
  brightness: Brightness.dark,
  canvasColor: Colors.black,
  cardColor: darkForeground,
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
    primary: Colors.white,
  ),
);

// final state = context.read(themeMode).state;
    // context.read(themeMode).state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;


// text - 