// import 'package:client/repository/local_storage_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final themeMode = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

// final theme = Provider<ThemeData>((ref) => _lightTheme);
// final darkTheme = Provider<ThemeData>((ref) => _darkTheme);

// void toggleTheme(WidgetRef ref) {
// switch (ref.read(themeMode)) {
//   case ThemeMode.dark:
//     ref.read(themeMode.notifier).update((state) => ThemeMode.light);
//     ref.read(localSecureStorageProvider).setTheme('light');
//     break;
//   case ThemeMode.light:
//     ref.read(themeMode.notifier).update((state) => ThemeMode.dark);
//     ref.read(localSecureStorageProvider).setTheme('dark');
//     break;
//   default:
// }
// ref.read(themeMode.notifier).update((state) =>
// ref.read(themeMode) == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
// }

// final isViewList = StateProvider<bool>((ref) => false);
// void toggleView(WidgetRef ref) {
//   ref
//       .read(isViewList.notifier)
//       .update((state) => ref.read(isViewList) == true ? false : true);
// }

// final _lightTheme = ThemeData(
//   brightness: Brightness.light,
//   splashColor: const Color(0xff161621),
//   canvasColor: const Color(0xffF4F4F4),
//   cardColor: Colors.white,
//   colorScheme: const ColorScheme.light(
//     background: Color(0xffF4F4F4),
//     primary: Color(0xff161621),
//   ),
// );

// final _darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   splashColor: const Color.fromARGB(255, 190, 190, 190),
//   canvasColor: const Color(0xff161621),
//   cardColor: const Color(0xff202030),
//   colorScheme: const ColorScheme.dark(
//     background: Color(0xff161621),
//     primary: Colors.white,
//   ),
// );
