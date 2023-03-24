import 'package:client/model/note_model.dart';
import 'package:client/utils/colors.dart';
import 'package:flutter/foundation.dart';
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
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: const Offset(1, 2),
                blurRadius: 4.0)
          ],
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).cardColor,
        ),
        child: InkWell(
          splashColor: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(4),
          onTap: () => Routemaster.of(context).push('/note/${note.id}'),
          onLongPress: () => {
            Scaffold.of(context).showBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32.0),
                  ),
                ),
                (context) => Container(
                      padding: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32)),
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              offset: const Offset(1, 1),
                              blurRadius: 3.0)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32)),
                        child: Container(
                          height: 260,
                          width: defaultTargetPlatform ==
                                      TargetPlatform.windows ||
                                  defaultTargetPlatform == TargetPlatform.linux
                              ? 480
                              : MediaQuery.of(context).size.width,
                          color: Theme.of(context).dialogBackgroundColor,
                          child: Column(children: [
                            PopupMenuItem(
                              enabled: false,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "  ${note.title}",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 18,
                                          overflow: TextOverflow.fade),
                                      softWrap: false,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                  )
                                ],
                              ),
                            ),
                            const Divider(height: 1),
                            PopupMenuItem(
                              onTap: () => Routemaster.of(context)
                                  .push('/note/${note.id}'),
                              child: Row(
                                children: const [
                                  Icon(Icons.edit),
                                  Text("  Edit Note"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () => onPressedFunc(),
                              child: Row(
                                children: const [
                                  Icon(Icons.delete),
                                  Text("  Delete Note"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              enabled: false,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.date_range_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "  Created At: ${Jiffy(note.createdAt).yMMMdjm}",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              enabled: false,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.update_sharp,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  Expanded(
                                    child: Text(
                                        "  Updated At: ${Jiffy(note.updatedAt).yMMMdjm}",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        softWrap: false,
                                        overflow: TextOverflow.fade),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    )),
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
                        overflow: TextOverflow.fade,
                        fontSize: 12,
                        color: kFairTextSecondary),
                    overflow: TextOverflow.fade,
                    textDirection: TextDirection.ltr,
                    softWrap: false,
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
          ),
        ),
      ),
    );
  }
}
