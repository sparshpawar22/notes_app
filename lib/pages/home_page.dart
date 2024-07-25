import 'package:flutter/material.dart';
import 'package:notes_app/components/my_drawer.dart';
import 'package:notes_app/pages/new_note_page.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../models/note_data.dart';
import 'edit_note_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<NoteData>(context, listen: false).initializeNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Notes',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<NoteData>(
              builder: (context, noteData, child) {
                return noteData.getAllNotes().isEmpty
                    ? Center(child: Text('Nothing here...'))
                    : ListView.builder(
                  itemCount: noteData.getAllNotes().length,
                  itemBuilder: (context, index) {
                    final note = noteData.getAllNotes()[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(
                          note.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            noteData.deleteNote(note);
                          },
                        ),
                        onTap: () async {
                          final updatedNote = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditNotePage(note: note),
                            ),
                          );
                          if (updatedNote != null) {
                            Provider.of<NoteData>(context, listen: false)
                                .updateNote(
                              updatedNote,
                              updatedNote.text,
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          Note? newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewNotePage()),
          );
          if (newNote == null) return;
          Provider.of<NoteData>(context, listen: false).addNewNote(newNote);
        },
        child: Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
