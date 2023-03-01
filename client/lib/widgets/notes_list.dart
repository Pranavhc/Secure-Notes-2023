import 'package:client/model/error_model.dart';
import 'package:client/model/note_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/repository/note_repository.dart';
import 'package:client/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final isViewList = StateProvider<bool>((ref) => false);

class NotesList extends ConsumerWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<ErrorModel?>(
      future: ref
          .watch(noteRepositoryProvider)
          .getNotes(ref.watch(userProvider)!.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ref.watch(isViewList)
            ? MasonryGridView.count(
                itemBuilder: (context, index) {
                  NoteModel note = snapshot.data!.data[index];
                  return NoteCard(note: note);
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
                  return NoteCard(note: note);
                },
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.data.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 16, right: 16),
              );
      },
    );
  }
}
