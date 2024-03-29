import 'package:client/screens/drawer.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/repository/note_repository.dart';
import 'package:client/widgets/notes_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isloading = false;

  void createNote(BuildContext context, WidgetRef ref) async {
    setState(() {
      _isloading = true;
    });
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    final errorModel = await ref.read(noteRepositoryProvider).createNote(token);
    if (errorModel.data != null) {
      navigator.push('/note/${errorModel.data.id}');
    } else {
      snackbar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
    setState(() {
      _isloading = false;
    });
  }

  void navigateToNote(BuildContext context, String id) {
    Routemaster.of(context).push('/note/$id');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        drawer: const MyDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          toolbarHeight: 80,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "ALL NOTES",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  onPressed: () => createNote(context, ref),
                  icon: _isloading
                      ? CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(Icons.note_add,
                          color: Theme.of(context).colorScheme.primary),
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
              ),
            ],
          ),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu_rounded,
                  color: Theme.of(context).colorScheme.primary),
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ),
        ),
        body: const NotesList(),
      ),
    );
  }
}
