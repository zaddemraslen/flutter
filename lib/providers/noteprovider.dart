import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _notes = [];

  List<Map<String, dynamic>> get notes => _notes;

  Future<void> addNote(Map<String, dynamic> note) async {
    await firestore.collection("Notes").add(note);
    //await refreshNotes();
  }

  /* Future<void> refreshNotes() async {
    /* return await FirebaseFirestore.instance
        .collection("Notes")
        .orderBy('position')
        .get(); */

    final querySnapshot =
        await firestore.collection("Notes").orderBy('position').get();
    /*_notes = */ querySnapshot.docs
        .map((doc) => _notes.add(doc.data)); //.toList();
    notifyListeners();
  } */
}
