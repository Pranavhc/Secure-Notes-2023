import 'package:client/model/note_model.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:routemaster/routemaster.dart';

class NoteCard extends ConsumerWidget {
  const NoteCard({Key? key, required this.note, required this.onPressedFunc})
      : super(key: key);
  final NoteModel note;
  final VoidCallback onPressedFunc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).cardColor,
        ),
        child: InkWell(
            splashColor: Theme.of(context).splashColor,
            borderRadius: BorderRadius.circular(4),
            onTap: () => Routemaster.of(context).push('/note/${note.id}'),
            onLongPress: () => {
                  showMenu(
                    color: Theme.of(context).cardColor,
                    context: context,
                    position: const RelativeRect.fromLTRB(90, 0, 0, 0),
                    items: [
                      PopupMenuItem(
                        onTap: () => onPressedFunc(),
                        child: Row(
                          children: const [
                            Icon(Icons.delete),
                            Text("  Delete Note"),
                          ],
                        ),
                      )
                    ],
                  ),
                },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Jiffy(note.updatedAt).fromNow().toString(),
                      style: const TextStyle(
                          fontSize: 12, color: kFairTextSecondary),
                      overflow: TextOverflow.fade,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      note.title,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
