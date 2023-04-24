/* import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:the_notebook/models/noteModel.dart';
import 'package:the_notebook/screen/note_editor.dart';
import 'package:the_notebook/screen/note_reader.dart';
import 'package:the_notebook/style/app_style.dart';
import 'package:the_notebook/widgets/grid.dart';
import 'package:the_notebook/widgets/note_card.dart';
import '../providers/Noteprovider';
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int newPosition = 0;

    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("FireNotes"),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent notes",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Consumer<NoteProvider>(builder: (context, viewModel, child)(
                return Expanded(
                  child: FutureBuilder(
                    future: query,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          List<noteCard> myList = snapshot.data!.docs
                              .map((note) => noteCard(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NoteReaderScreen(note),
                                          ));
                                    },
                                    noteData: noteModel(
                                        note.id,
                                        note['color_id'],
                                        note["creation_date"],
                                        note["note_content"],
                                        note["note_title"],
                                        int.parse(note["position"].toString())),
                                  ))
                              .toList();

                          newPosition = myList.length;
                          return DemoReorderableGrid(
                            mycards: myList,
                          );
                        }
                      }
                      return Text(
                        "There is no notes",
                        style: GoogleFonts.nunito(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
          ,
            )],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteEditorScreen(
                        position: newPosition,
                      )));
        },
        label: Text(""),
        icon: Icon(Icons.add),
      ),
    );
  }
}
 */
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_notebook/models/noteModel.dart';
import 'package:the_notebook/screen/note_editor.dart';
import 'package:the_notebook/screen/note_reader.dart';
import 'package:the_notebook/style/app_style.dart';
import 'package:the_notebook/widgets/grid.dart';
import 'package:the_notebook/widgets/note_card.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<homeScreen> {
  late Future<QuerySnapshot<Map<String, dynamic>>> query;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    query = getNotes();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getNotes() async {
    // Code to get all of the documents of a collection Notes
    return await FirebaseFirestore.instance
        .collection("Notes")
        .orderBy('position')
        .get();
  }

  Future<void> updateGrid() async {
    setState(() {
      query = getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    int newPosition = 0;
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("FireNotes"),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent notes",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: FutureBuilder(
                future: query,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      List<noteCard> myList = snapshot.data!.docs
                          .map((note) => noteCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NoteReaderScreen(note),
                                      ));
                                },
                                noteData: noteModel(
                                    note.id,
                                    note['color_id'],
                                    note["creation_date"],
                                    note["note_content"],
                                    note["note_title"],
                                    int.parse(note["position"].toString())),
                              ))
                          .toList();

                      newPosition = myList.length;
                      return DemoReorderableGrid(
                        mycards: myList,
                      );
                    }
                  }
                  return Text(
                    "There is no notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteEditorScreen(
                        position: newPosition,
                        updateGrid: updateGrid,
                      )));
        },
        label: Text(""),
        icon: Icon(Icons.add),
      ),
    );
  }
}
