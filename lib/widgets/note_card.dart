import 'package:flutter/material.dart';
import 'package:the_notebook/models/noteModel.dart';

import '../style/app_style.dart';

class noteCard extends StatefulWidget {
  final noteModel noteData;
  final Function()? onTap;

  noteCard({super.key, required this.onTap, required noteModel this.noteData});

  @override
  State<noteCard> createState() => _noteCardState();
}

class _noteCardState extends State<noteCard> {
  late noteModel myNote;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppStyle.cardsColor[widget.noteData.color_id],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Expanded(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.noteData.note_title, style: AppStyle.mainTitle),
                SizedBox(
                  height: 4.0,
                ),
                Text(widget.noteData.creation_date.substring(0, 10),
                    style: AppStyle.dateTitle),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  widget.noteData.note_content,
                  style: AppStyle.mainContent,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ],
            ))),
            Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text((widget.noteData.position + 1).toString(),
                    style: AppStyle.mainTitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
