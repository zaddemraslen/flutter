/* import 'dart:html';

import 'package:flutter/material.dart';
import 'package:the_notebook/models/noteModel.dart';

import 'package:the_notebook/style/app_style.dart';

class blockCard extends StatefulWidget {
  final String path;

  blockCard({super.key, required String this.path});

  @override
  State<blockCard> createState() => _blockCardState();
}

class _blockCardState extends State<blockCard> {
  late noteModel myNote;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image:  DecorationImage(
      image: FileImage(File(widget.path)),
      fit: BoxFit.cover,
    ),,
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
                Text(widget.path, style: AppStyle.mainTitle),
              ],
            ))),
          ],
        ),
      ),
    );
  }
}
 */