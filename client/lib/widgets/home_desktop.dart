// import 'package:client/model/error_model.dart';
// import 'package:client/model/note_model.dart';
// import 'package:client/repository/auth_repository.dart';
// import 'package:client/repository/note_repository.dart';
// import 'package:client/screens/drawer.dart';
// import 'package:client/widgets/note_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:multi_split_view/multi_split_view.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

// final selectedNoteID = StateProvider((ref) => "6405c494adf8f24e4e3cb280");

// class HomeScreenDesktop extends ConsumerWidget {
//   const HomeScreenDesktop({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       drawer: const MyDrawer(),
//       body: MultiSplitView(
//           children: [
//             const NotesListDesk(),
//             NoteScreenDesk(id: ref.watch(selectedNoteID))
//           ],
//           dividerBuilder:
//               (axis, index, resizable, dragging, highlighted, themeData) {
//             return Icon(
//               Icons.drag_indicator,
//               color: highlighted ? Colors.cyan : Colors.grey[400],
//             );
//           }),
//     );
//   }
// } 

// // NoteScreen
// class NoteScreenDesk extends ConsumerStatefulWidget {
//   final String id;
//   const NoteScreenDesk({super.key, required this.id});

//   @override
//   NoteStateScreenDesk createState() => NoteStateScreenDesk();
// }

// class NoteStateScreenDesk extends ConsumerState<NoteScreenDesk> {
//   TextEditingController titleController =
//       TextEditingController(text: "Untitled");

//   quill.QuillController? _controller = quill.QuillController.basic();
//   ErrorModel? errorModel;

//   bool _isloading = false;

//   @override
//   void initState() {
//     super.initState();
//     getNote();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     titleController.dispose();
//   }

//   void getNote() async {
//     setState(() {
//       _isloading = true;
//     });

//     errorModel = await ref
//         .read(noteRepositoryProvider)
//         .getNoteById(ref.read(userProvider)!.token, widget.id);

//     if (errorModel!.data != null) {
//       titleController.text = errorModel!.data.title;
//       _controller = quill.QuillController(
//           document: errorModel!.data.content.isEmpty
//               ? quill.Document()
//               : quill.Document.fromJson(errorModel!.data.content),
//           selection: const TextSelection.collapsed(offset: 0));

//       setState(() {
//         _isloading = false;
//       });
//     }
//   }

//   void updateNote(WidgetRef ref, String title) {
//     final snackbar = ScaffoldMessenger.of(context);
//     ref
//         .read(noteRepositoryProvider)
//         .updateNote(
//           token: ref.read(userProvider)!.token,
//           id: widget.id,
//           title: title,
//           content: _controller!.document.toDelta().toJson(),
//         )
//         .then(
//           (value) => snackbar.showSnackBar(SnackBar(
//               content: Text(value.error ?? 'Saved!!!'),
//               duration: const Duration(seconds: 1))),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isloading
//         ? const Center(child: CircularProgressIndicator())
//         : Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Row(children: [
//                     SizedBox(
//                       width: 200,
//                       child: TextField(
//                         onSubmitted: (value) => updateNote(ref, value),
//                         controller: titleController,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.only(left: 10),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                         child:
//                             quill.QuillToolbar.basic(controller: _controller!)),
//                   ]),
//                   Expanded(
//                     child: Card(
//                       elevation: 5,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: quill.QuillEditor.basic(
//                           controller: _controller!,
//                           readOnly: false, // true for view only mode
//                           keyboardAppearance: Brightness.dark,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }

// // NotesList
// class NotesListDesk extends ConsumerStatefulWidget {
//   const NotesListDesk({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => NotesListDeskState();
// }

// class NotesListDeskState extends ConsumerState<NotesListDesk> {
//   void deleteNote(BuildContext context, String id) async {
//     String token = ref.read(userProvider)!.token;
//     final snackbar = ScaffoldMessenger.of(context);
//     await ref
//         .read(noteRepositoryProvider)
//         .deleteNote(token, id)
//         .then((value) => {
//               snackbar.showSnackBar(SnackBar(
//                   content: Text(value.error ?? 'Deleted!!!'),
//                   duration: const Duration(seconds: 1))),
//             });
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ErrorModel?>(
//       future: ref
//           .watch(noteRepositoryProvider)
//           .getNotes(ref.watch(userProvider)?.token ?? ''),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 6.0, top: 6.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () => Scaffold.of(context).openDrawer(),
//                     icon: Icon(Icons.menu_rounded,
//                         color: Theme.of(context).colorScheme.primary),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text("ALL NOTES",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).colorScheme.primary)),
//                   ),
//                 ],
//               ),
//             ),
//             ListView.builder(
//               itemBuilder: (context, index) {
//                 NoteModel note = snapshot.data!.data[index];
//                 return NoteCard(
//                     note: note,
//                     onPressedFunc: () => deleteNote(context, note.id));
//               },
//               physics: const BouncingScrollPhysics(),
//               itemCount: snapshot.data!.data.length,
//               shrinkWrap: true,
//               padding: const EdgeInsets.only(left: 16, right: 16),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
