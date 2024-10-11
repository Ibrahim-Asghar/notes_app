import 'package:flutter/cupertino.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  void addNote(Note note) {
    notes.add(note);
    // sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    // sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    // sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    await ApiService.fetchNotes("Ibrahim");
  }
}
