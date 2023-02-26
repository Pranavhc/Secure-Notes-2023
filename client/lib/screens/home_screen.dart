import 'package:client/colors.dart';
import 'package:client/model/error_model.dart';
import 'package:client/model/note_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/repository/note_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).logOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createNote(BuildContext context, WidgetRef ref) async {
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    final errorModel = await ref.read(noteRepositoryProvider).createNote(token);
    if (errorModel.data != null) {
      navigator.push('/note/${errorModel.data.id}');
    } else {
      snackbar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  void navigateToNote(BuildContext context, String id) {
    Routemaster.of(context).push('/note/$id');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kFairText,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => createNote(context, ref),
              icon: const Icon(Icons.add, color: kDarkText),
            ),
            IconButton(
              onPressed: () => logOut(ref),
              icon: const Icon(Icons.logout, color: kDarkText),
            )
          ],
        ),
        body: FutureBuilder<ErrorModel?>(
          future: ref
              .watch(noteRepositoryProvider)
              .getNotes(ref.watch(userProvider)!.token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: Container(
                width: 600,
                margin: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (context, index) {
                    NoteModel note = snapshot.data!.data[index];

                    return InkWell(
                      onTap: () =>
                          Routemaster.of(context).push('/note/${note.id}'),
                      child: SizedBox(
                        height: 50,
                        child: Card(
                          child: Center(
                            child: Text(
                              note.title,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ));
  }
}
