import 'package:client/repository/hive_db_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// View Settings
final isViewList = StateProvider<bool>((ref) => ref.read(hiveDbProvider).getView() == 'list' ? true : false);

void toggleView(WidgetRef ref) {
  ref.read(hiveDbProvider).setView(ref.read(hiveDbProvider).getView() == 'grid' ? 'list' : 'grid');
  ref.read(isViewList.notifier).update((state) => ref.read(isViewList) == true ? false : true);
}

// Theme Settings
final themeMode = StateProvider<ThemeMode>((ref) => ref.read(hiveDbProvider).getTheme() == 'light' ? ThemeMode.light : ThemeMode.dark);

void toggleTheme(WidgetRef ref) {
  ref.read(hiveDbProvider).setTheme(ref.read(hiveDbProvider).getTheme() == 'light' ? 'dark' : 'light');
ref.read(themeMode.notifier).update((state) => ref.read(themeMode) == ThemeMode.light? ThemeMode.dark: ThemeMode.light);
}
