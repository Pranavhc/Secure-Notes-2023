import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/model/error_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/repository/hive_db_repository.dart';
import 'package:client/utils/router.dart';
import 'package:client/utils/theme_data.dart';
import 'package:client/utils/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  await Hive.openBox('local-data');
  runApp(const ProviderScope(child: MyApp()));

  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux) {
    doWhenWindowReady(() {
      const minSize = Size(480, 720);
      appWindow.title = "Secure Notes";
      appWindow.alignment = Alignment.center;
      appWindow.minSize = minSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
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
    if (HiveDBRepository().getToken().isEmpty) FlutterNativeSplash.remove();

    final user = ref.watch(userProvider);
    if (user != null) FlutterNativeSplash.remove();

    return MaterialApp.router(
      title: 'Secure Notes',
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeMode),
      theme: lightTheme,
      darkTheme: darkTheme,
      routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) =>
              user != null ? loggedInRoutes : loggedOutRoutes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
