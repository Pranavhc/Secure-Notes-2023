import 'package:client/screens/drawer.dart';
import 'package:client/model/error_model.dart';
import 'package:client/model/note_model.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/repository/note_repository.dart';
import 'package:client/utils/colors.dart';
import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void createNote(BuildContext context, WidgetRef ref) async {
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    final errorModel = await ref.read(noteRepositoryProvider).createNote(token);
    if (errorModel.data != null) {
      navigator.push('/note/${errorModel.data.id}');
    } else {
      snackbar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  void navigateToNote(BuildContext context, String id) {
    Routemaster.of(context).push('/note/$id');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        drawer: const MyDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          toolbarHeight: 100,
          elevation: 0.5,
          centerTitle: true,
          title: Column(
            children: [
              // make it time responsive later.
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Welcome 👋",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary)),
              ),
              const Text("and have a great day!",
                  style: TextStyle(fontSize: 16, color: kFairTextSecondary)),
            ],
          ),
          leading: Builder(
            builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(Icons.menu_rounded,
                    color: Theme.of(context).colorScheme.primary)),
          ),
        ),
        body: FutureBuilder<ErrorModel?>(
          future: ref
              .watch(noteRepositoryProvider)
              .getNotes(ref.watch(userProvider)!.token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return MasonryGridView.count(
              itemBuilder: (context, index) {
                NoteModel note = snapshot.data!.data[index];
                return TaskUI(task: note);
              },
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              itemCount: snapshot.data!.data.length,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
            onPressed: () => createNote(context, ref),
            child: const Text("Create New")));
  }
}

class TaskUI extends StatelessWidget {
  const TaskUI({Key? key, required this.task}) : super(key: key);
  final NoteModel task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Routemaster.of(context).push('/note/${task.id}'),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                task.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )),
    );
  }
}
