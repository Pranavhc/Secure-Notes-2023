import 'package:client/model/error_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/utils/router.dart';
import 'package:client/utils/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
    FlutterNativeSplash.remove();
    return MaterialApp.router(
      title: 'Secure Notes',
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeMode),
      theme: ref.watch(lightTheme),
      darkTheme: ref.watch(darkTheme),
      routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) =>
              user != null ? loggedInRoutes : loggedOutRoutes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
