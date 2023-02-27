import 'package:client/model/error_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/utils/router.dart';
import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  ErrorModel? errorModel;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    errorModel = await ref.read(authRepositoryProvider).getUserData();
    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update((state) => errorModel!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return MaterialApp.router(
      title: 'Secure Notes',
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeMode),
      theme: ref.watch(theme),
      darkTheme: ref.watch(darkTheme),
      routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) =>
              user != null ? loggedInRoutes : loggedOutRoutes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

// LOOK INTO ROUTING

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

