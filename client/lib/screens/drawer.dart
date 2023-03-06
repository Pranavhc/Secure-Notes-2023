import 'package:client/repository/auth_repository.dart';
import 'package:client/utils/colors.dart';
import 'package:client/utils/settings.dart';
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
      backgroundColor: Colors.amber,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.color,
            image: const DecorationImage(
              image: AssetImage("assets/flowers.gif"),
              opacity: 0.8,
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: ref.watch(themeMode) == ThemeMode.dark
                  ? Alignment.topLeft
                  : Alignment.topRight,
              end: ref.watch(themeMode) == ThemeMode.dark
                  ? Alignment.topRight
                  : Alignment.topLeft,
              colors: const [
                Colors.purpleAccent,
                Colors.pinkAccent,
                Colors.pink
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 8.0),
                  child: SvgPicture.string(RandomAvatarString(
                          // trBackground: true,
                          "${ref.read(userProvider)?.name ?? 'zero'} ${ref.read(userProvider)?.email ?? '0'}"),
                      height: 100, width: 100),
                ),
              ),
              Center(
                child: Text(
                  ref.read(userProvider)?.name.toUpperCase() ?? '',
                  style: const TextStyle(
                      color: kDarkText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Center(
                  child: Text(
                    ref.read(userProvider)?.email ?? '',
                    style: const TextStyle(fontSize: 16, color: kDarkText),
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                  child: Container(
                    color: Theme.of(context).canvasColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      ListTile(
                                          title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Notes View"),
                                          IconButton(
                                            onPressed: () => toggleView(ref),
                                            icon: ref.watch(isViewList)
                                                ? Icon(Icons.list_alt_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary)
                                                : Icon(Icons.grid_view_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                          )
                                        ],
                                      )),
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Theme Mode"),
                                            IconButton(
                                              onPressed: () => toggleTheme(ref),
                                              icon: ref.watch(themeMode) ==
                                                      ThemeMode.dark
                                                  ? Icon(Icons.nightlight,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary)
                                                  : Icon(Icons.sunny,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // // ///

                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Sign out"),
                                IconButton(
                                  onPressed: () => logOut(context, ref),
                                  icon: Icon(Icons.logout,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
