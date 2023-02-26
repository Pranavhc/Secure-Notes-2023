import 'package:client/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class NoteScreen extends ConsumerStatefulWidget {
  final String id;
  const NoteScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<NoteScreen> createState() => NoteStateScreen();
}

class NoteStateScreen extends ConsumerState<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kFairText,
        elevation: 0,
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.lock),
            label: Text("share"),
          )
        ],
      ),
      body: Center(child: Text(widget.id)),
    );
  }
}
