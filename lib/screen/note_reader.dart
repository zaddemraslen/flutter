import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_notebook/style/app_style.dart';

class NotePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintDarkgrey = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 1.0;

    //Step 4
    final paintPink = Paint()
      ..color = Colors.pinkAccent
      ..strokeWidth = 2.5;
    final int heigth = size.height.toInt();

    canvas.drawLine(Offset(15.0, 0), Offset(15.0, size.height), paintPink);
    canvas.drawLine(Offset(19.0, 0), Offset(19.0, size.height), paintPink);

    for (int i = 80; i < heigth; i += 37) {
      canvas.drawLine(Offset(20.0, i.toDouble()),
          Offset(size.width - 20.0, i.toDouble()), paintDarkgrey);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {super.key});
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreen();
}

class _NoteReaderScreen extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        title: Text(widget.doc["note_title"], style: AppStyle.mainTitle),
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomPaint(
              painter: NotePainter(),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doc["note_content"],
                        style: AppStyle.mainContent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
