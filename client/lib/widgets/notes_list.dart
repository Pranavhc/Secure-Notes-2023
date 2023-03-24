import 'package:client/model/error_model.dart';
import 'package:client/model/note_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/repository/note_repository.dart';
import 'package:client/utils/settings.dart';
import 'package:client/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesList extends ConsumerStatefulWidget {
  const NotesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => NotesListState();
}

class NotesListState extends ConsumerState<NotesList> {
  void deleteNote(BuildContext context, String id) async {
    String token = ref.read(userProvider)!.token;
    final snackbar = ScaffoldMessenger.of(context);
    await ref
        .read(noteRepositoryProvider)
        .deleteNote(token, id)
        .then((value) => {
              snackbar.showSnackBar(SnackBar(
                  content: Text(value.error ?? 'Deleted!!!'),
                  duration: const Duration(seconds: 1))),
            });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ErrorModel?>(
        future: ref
            .watch(noteRepositoryProvider)
            .getNotes(ref.watch(userProvider)?.token ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.data.length > 0
              ? ref.watch(isViewList) == false
                  ? MasonryGridView.count(
                      itemBuilder: (context, index) {
                        NoteModel note = snapshot.data!.data[index];
                        return NoteCard(
                          note: note,
                          onPressedFunc: () => deleteNote(context, note.id),
                        );
                      },
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      itemCount: snapshot.data!.data.length,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(12),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        NoteModel note = snapshot.data!.data[index];
                        return NoteCard(
                            note: note,
                            onPressedFunc: () => deleteNote(context, note.id));
                      },
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.data.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                    )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32, bottom: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            'assets/batman.gif',
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            height: 260,
                            width: 260,
                          ),
                        ),
                      ),
                      const Text(
                        "wow, the emptyness! it's creepy 🥶",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
        });
  }
}
