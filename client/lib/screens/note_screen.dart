import 'package:client/utils/colors.dart';
import 'package:client/model/error_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/repository/note_repository.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class NoteScreen extends ConsumerStatefulWidget {
  final String id;
  const NoteScreen({super.key, required this.id});

  @override
  ConsumerState<NoteScreen> createState() => NoteStateScreen();
}

class NoteStateScreen extends ConsumerState<NoteScreen> {
  TextEditingController titleController =
      TextEditingController(text: "Untitled");

  quill.QuillController? _controller = quill.QuillController.basic();

  ErrorModel? errorModel;

  @override
  void initState() {
    super.initState();
    getNote();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void getNote() async {
    errorModel = await ref
        .read(noteRepositoryProvider)
        .getNoteById(ref.read(userProvider)!.token, widget.id);

    if (errorModel!.data != null) {
      titleController.text = errorModel!.data.title;
      _controller = quill.QuillController(
          document: errorModel!.data.content.isEmpty
              ? quill.Document()
              : quill.Document.fromJson(errorModel!.data.content),
          selection: const TextSelection.collapsed(offset: 0));

      setState(() {});
    }
  }

  void updateNote(WidgetRef ref, String title) {
    ref.read(noteRepositoryProvider).updateNote(
          token: ref.read(userProvider)!.token,
          id: widget.id,
          title: title,
          content: _controller!.document.toDelta().toJson(),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kFairText,
          elevation: 0,
          // actions: [],
          title: Row(
            children: [
              Image.asset('assets/google-logo.png', height: 45),
              const SizedBox(width: 10),
              SizedBox(
                width: 200,
                child: TextField(
                  onSubmitted: (value) => updateNote(ref, value),
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kDarkText)),
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              )
            ],
          ),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: kFairTextSecondary)),
              )),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                quill.QuillToolbar.basic(controller: _controller!),
                Expanded(
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: quill.QuillEditor.basic(
                        controller: _controller!,
                        readOnly: false, // true for view only mode
                        keyboardAppearance: Brightness.dark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
