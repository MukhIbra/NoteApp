import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/components/my_drawer.dart';
import 'package:mynotes/model/notes_database.dart';
import 'package:mynotes/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../components/note_tile.dart';
import '../model/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    readNotes();
  }

  var _controller = TextEditingController();

  void onUpdate(Note note) {
    _controller.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Note'),
        content: TextField(
          controller: _controller,
        ),
        actions: [
          TextButton(
              onPressed: () {
                context
                    .read<NotesDatabase>()
                    .updateNote(note.id, _controller.text);
                _controller.clear();
                Navigator.of(context).pop();
              },
              child: Text(
                'Edit',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ))
        ],
      ),
    );
  }

  void onDelete(int id) {
    context.read<NotesDatabase>().deleteNote(id);
  }

  void onAddNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add a new note'),
        content: TextField(
          controller: _controller,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NotesDatabase>().addNote(_controller.text);
              Navigator.of(context).pop();
              _controller.clear();
            },
            child: Text('Create'),
          )
        ],
      ),
    );
  }

  void readNotes() {
    context.read<NotesDatabase>().readNotes();
  }

  @override
  Widget build(BuildContext context) {
    final db = context.watch<NotesDatabase>();

    List<Note> current = db.currentNotes;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
        ),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: onAddNote,
          child: Icon(Icons.add,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text('Notes',
                  style: GoogleFonts.dmSerifText(
                      fontSize: 48,
                      color: Theme.of(context).colorScheme.inversePrimary)),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: current.length,
                    itemBuilder: (context, index) {
                      final note = current[index];
                      return NoteTile(
                        text: note.text,
                        onUpdate: () => onUpdate(note),
                        onDelete: () => onDelete(note.id),
                      );
                    }))
          ],
        ));
  }
}
// Provider
/*

flutter pub add isar isar_flutter_libs path_provider
flutter pub add -d isar_generator build_runner
flutter pub add google_fonts

 */
