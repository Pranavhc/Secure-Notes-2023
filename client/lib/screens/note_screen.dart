import 'package:client/model/error_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/repository/note_repository.dart';
import 'package:client/utils/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

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

  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    getNote();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  void getNote() async {
    setState(() {
      _isloading = true;
    });

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

      setState(() {
        _isloading = false;
      });
    }
  }

  void updateNote(WidgetRef ref, String title) {
    final snackbar = ScaffoldMessenger.of(context);
    ref
        .read(noteRepositoryProvider)
        .updateNote(
          token: ref.read(userProvider)!.token,
          id: widget.id,
          title: title,
          content: _controller!.document.toDelta().toJson(),
        )
        .then(
          (value) => snackbar.showSnackBar(SnackBar(
              content: Text(value.error ?? 'Saved!'),
              duration: const Duration(seconds: 1))),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Routemaster.of(context).replace('/home'),
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.primary),
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                onSubmitted: (value) => updateNote(ref, value),
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10),
                ),
              ),
            ),
            IconButton(
              onPressed: () => updateNote(ref, titleController.text),
              icon: Icon(Icons.save,
                  color: Theme.of(context).colorScheme.primary),
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
            )
          ],
        ),
      ),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: defaultTargetPlatform == TargetPlatform.android ||
                        defaultTargetPlatform == TargetPlatform.iOS
                    ? const EdgeInsets.only(bottom: 8)
                    : const EdgeInsets.only(bottom: 0),
                child: Column(
                  children: [
                    defaultTargetPlatform == TargetPlatform.windows ||
                            defaultTargetPlatform == TargetPlatform.linux
                        ? quill.QuillToolbar.basic(
                            controller: _controller!,
                            multiRowsDisplay: false,
                            showClearFormat: false,
                            showDividers: true,
                            showFontSize: false,
                            showSmallButton: true,
                            showInlineCode: false,
                            axis: Axis.horizontal,
                            customButtons: [
                              quill.QuillCustomButton(
                                icon: ref.watch(themeMode) == ThemeMode.dark
                                    ? Icons.nightlight
                                    : Icons.sunny,
                                onTap: () => toggleTheme(ref),
                              )
                            ],
                            iconTheme: quill.QuillIconTheme(
                                borderRadius: 18,
                                iconSelectedFillColor:
                                    Theme.of(context).colorScheme.primary,
                                iconSelectedColor:
                                    Theme.of(context).colorScheme.background),
                          )
                        : const Padding(padding: EdgeInsets.all(0)),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              offset: const Offset(2, 1),
                              blurRadius: 4,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: defaultTargetPlatform ==
                                      TargetPlatform.android ||
                                  defaultTargetPlatform == TargetPlatform.iOS
                              ? const EdgeInsets.only(
                                  left: 16, right: 16, top: 16, bottom: 32)
                              : const EdgeInsets.only(
                                  left: 16, right: 16, top: 16, bottom: 0),
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
            ),
      resizeToAvoidBottomInset: true,
      bottomSheet: defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS
          ? Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: quill.QuillToolbar.basic(
                controller: _controller!,
                multiRowsDisplay: false,
                showClearFormat: false,
                showDividers: true,
                showFontSize: false,
                showSmallButton: true,
                showInlineCode: false,
                axis: Axis.horizontal,
                customButtons: [
                  quill.QuillCustomButton(
                    icon: ref.watch(themeMode) == ThemeMode.dark
                        ? Icons.nightlight
                        : Icons.sunny,
                    onTap: () => toggleTheme(ref),
                  )
                ],
                iconTheme: quill.QuillIconTheme(
                    borderRadius: 18,
                    iconSelectedFillColor:
                        Theme.of(context).colorScheme.primary,
                    iconSelectedColor:
                        Theme.of(context).colorScheme.background),
              ),
            )
          : const Padding(padding: EdgeInsets.all(0)),
    );
  }
}
