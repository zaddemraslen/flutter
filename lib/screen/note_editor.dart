/* import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_notebook/style/app_style.dart';
import '../providers/Noteprovider';

class NoteEditorScreen extends StatefulWidget {
  final int position;

  const NoteEditorScreen({
    super.key,
    required this.position,
  });

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = Random().nextInt(AppStyle.cardsColor.length);
    String date = DateTime.now().toString();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Note Title'),
                style: AppStyle.mainTitle,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                date,
                style: AppStyle.dateTitle,
              ),
              SizedBox(
                height: 28.0,
              ),
              TextField(
                controller: _mainController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Note content'),
                style: AppStyle.mainTitle,
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppStyle.accentColor,
          onPressed: () {
            Provider.of<NoteProvider>(context, listen: false).addNote({
              "note_title": _titleController.text,
              "creation_date": date,
              "note_content": _mainController.text,
              "color_id": color_id,
              "position": widget.position,
            });
          },
          child: Icon(Icons.save)),
    );
  }
}
 */
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_notebook/screen/home_screen.dart';
import 'package:the_notebook/style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  final int position;
  final void Function() updateGrid;
  const NoteEditorScreen(
      {super.key, required this.position, required this.updateGrid});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = Random().nextInt(AppStyle.cardsColor.length);
    String date = DateTime.now().toString();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Note Title'),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            const SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Note content'),
              style: AppStyle.mainTitle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppStyle.accentColor,
          onPressed: () async {
            FirebaseFirestore.instance.collection("Notes").add({
              "note_title": _titleController.text,
              "creation_date": date,
              "note_content": _mainController.text,
              "color_id": color_id,
              "position": widget.position,
            }).then((value) {
              print(value.id);
              widget.updateGrid;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const homeScreen()),
                  (route) => false);
            }).catchError(
                (error) => print("Failed to add  new Note due to $error"));
          },
          child: const Icon(Icons.save)),
    );
  }
}
