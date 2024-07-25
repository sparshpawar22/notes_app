import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/models/note.dart';

class HiveDatabase {
  final _myBox = Hive.box('note_database');

  //load note
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    //if there exist notes, return that otherwise return empty list
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        // create individual note
        Note individualNote =
        Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        //add to list
        savedNotesFormatted.add(individualNote);
      }
    }
    return savedNotesFormatted;
  }
  //save notes
  void savedNotes(List<Note>allNotes) {
    List<List<dynamic>>allNotesFormatted = [

    ];

    // each note has an id and text
    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    //then store into hive
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}