import 'package:client/model/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note}) : super(key: key);
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
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
            onLongPress: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                note.title,
                style: const TextStyle(fontSize: 16),
              ),
            )),
      ),
    );
  }
}
