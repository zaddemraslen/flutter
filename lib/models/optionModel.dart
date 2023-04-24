import 'package:cloud_firestore/cloud_firestore.dart';

class optionModel {
  String text = "";
  bool isChecked = false;

  noteModel(text, isChecked) {
    this.text = text;
    this.isChecked = isChecked;
  }

  String getText() {
    return text;
  }

  bool getState() {
    return isChecked;
  }

  void setText(String text) {
    this.text = text;
  }

  void changeState() {
    isChecked = !isChecked;
  }
}

/////
///
///
class Block {
  String title;
  String imageUrl;
  List<Note> notes;

  Block({required this.title, required this.imageUrl, required this.notes});

  factory Block.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final notes = (data['notes'] as List)
        .map((note) => Note.fromFirestore(note))
        .toList();
    return Block(
      title: data['title'],
      imageUrl: data['imageUrl'],
      notes: notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'notes': notes.map((note) => note.toMap()).toList(),
    };
  }
}

class Note {
  List<String> texts;
  List<String> imageUrls;
  List<String> recordingUrls;
  List<String> texts2;
  List<Checklist> checklists;

  Note({
    required this.texts,
    required this.imageUrls,
    required this.recordingUrls,
    required this.texts2,
    required this.checklists,
  });

  factory Note.fromFirestore(Map<String, dynamic> data) {
    final checklists = (data['checklists'] as List)
        .map((checklist) => Checklist.fromFirestore(checklist))
        .toList();
    return Note(
      texts: List<String>.from(data['texts']),
      imageUrls: List<String>.from(data['imageUrls']),
      recordingUrls: List<String>.from(data['recordingUrls']),
      texts2: List<String>.from(data['texts2']),
      checklists: checklists,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'texts': texts,
      'imageUrls': imageUrls,
      'recordingUrls': recordingUrls,
      'texts2': texts2,
      'checklists': checklists.map((checklist) => checklist.toMap()).toList(),
    };
  }
}

class Checklist {
  String title;
  List<ChecklistOption> options;

  Checklist({required this.title, required this.options});

  factory Checklist.fromFirestore(Map<String, dynamic> data) {
    final options = (data['options'] as List)
        .map((option) => ChecklistOption.fromFirestore(option))
        .toList();
    return Checklist(
      title: data['title'],
      options: options,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'options': options.map((option) => option.toMap()).toList(),
    };
  }
}

class ChecklistOption {
  String text;
  bool checked;

  ChecklistOption({required this.text, required this.checked});

  factory ChecklistOption.fromFirestore(Map<String, dynamic> data) {
    return ChecklistOption(
      text: data['text'],
      checked: data['checked'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'checked': checked,
    };
  }
}
