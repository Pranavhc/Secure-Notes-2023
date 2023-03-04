import 'package:client/repository/auth_repository.dart';
import 'package:client/utils/colors.dart';
import 'package:client/utils/theme_settings.dart';
import 'package:client/utils/view_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:routemaster/routemaster.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  void logOut(BuildContext context, WidgetRef ref) {
    ref.read(authRepositoryProvider).logOut();
    ref.read(userProvider.notifier).update((state) => null);
    Routemaster.of(context).popUntil((routeData) => routeData.path == '/');
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
            ListTile(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notes View"),
                IconButton(
                  onPressed: () => toggleView(ref),
                  icon: ref.watch(isViewList)
                      ? Icon(Icons.grid_view_rounded,
                          color: Theme.of(context).colorScheme.primary)
                      : Icon(Icons.list_alt_rounded,
                          color: Theme.of(context).colorScheme.primary),
                )
              ],
            )),
            const Divider(color: kFairTextSecondary),
            ListTile(
              // tileColor: Theme.of(context).cardColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Theme Mode"),
                  IconButton(
                    onPressed: () => toggleTheme(ref),
                    icon: ref.watch(themeMode) == ThemeMode.dark
                        ? Icon(Icons.nightlight,
                            color: Theme.of(context).colorScheme.primary)
                        : Icon(Icons.sunny,
                            color: Theme.of(context).colorScheme.primary),
                  )
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
                    onPressed: () => logOut(context, ref),
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
