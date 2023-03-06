import 'package:client/utils/settings.dart';
import 'package:client/widgets/infinite_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import '../widgets/elevated_button.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 360, child: InfiniteCarouselWidget()),
              //
              Center(
                child: CustomElevatedButton(
                  onPressedFunc: () => Routemaster.of(context).push('/sign-in'),
                  imgpath: "assets/email-logo.png",
                  label: "Sign in with email",
                  radius: 4,
                  top: 18,
                  bottom: 18,
                  width: 240,
                  color1: Theme.of(context).colorScheme.primary,
                  color2: Theme.of(context).colorScheme.primary,
                ),
              ),
              Center(
                child: CustomElevatedButton(
                  onPressedFunc: () => Routemaster.of(context).push('/sign-up'),
                  imgpath: "assets/email-logo.png",
                  label: "Sign up with email",
                  radius: 4,
                  bottom: 18,
                  width: 240,
                  color1: Theme.of(context).colorScheme.primary,
                  color2: Theme.of(context).colorScheme.primary,
                ),
              ),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton.small(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () => toggleTheme(ref),
          child: ref.watch(themeMode) == ThemeMode.dark
              ? Icon(Icons.nightlight,
                  color: Theme.of(context).colorScheme.background)
              : Icon(Icons.sunny,
                  color: Theme.of(context).colorScheme.background),
        ),
      ),
    );
  }
}
