import 'package:client/repository/auth_repository.dart';
import 'package:client/utils/colors.dart';
import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_avatar/random_avatar.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  void toggleTheme(WidgetRef ref) {
    ref.read(themeMode.notifier).update((state) =>
        ref.read(themeMode) == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark);
  }

  void logOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).logOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Theme.of(context).canvasColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 32, bottom: 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SvgPicture.string(
                          RandomAvatarString(ref.read(userProvider)!.name),
                          height: 60,
                          width: 60),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ref.read(userProvider)!.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(ref.read(userProvider)!.email),
                      ],
                    ),
                  ]),
            ),
            const Divider(color: kFairTextSecondary),
            //
            ListTile(
              // tileColor: Theme.of(context).cardColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dark Mode"),
                  Switch.adaptive(
                    activeColor: Colors.deepPurpleAccent,
                    onChanged: (value) => toggleTheme(ref),
                    value: ref.read(themeMode) == ThemeMode.dark ? true : false,
                  ),
                ],
              ),
            ),

            const Divider(color: kFairTextSecondary),

            ListTile(
              // tileColor: Theme.of(context).cardColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Logout"),
                  IconButton(
                    onPressed: () => logOut(ref),
                    icon: Icon(Icons.logout,
                        color: Theme.of(context).colorScheme.primary),
                  )
                ],
              ),
            ),
            const Divider(color: kFairTextSecondary),
          ],
        ),
      ),
    );
  }
}
