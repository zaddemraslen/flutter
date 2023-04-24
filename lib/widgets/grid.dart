import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:the_notebook/models/noteModel.dart';
import 'package:the_notebook/widgets/note_card.dart';

class DemoReorderableGrid extends StatefulWidget {
  final List<noteCard> mycards;

  const DemoReorderableGrid({Key? key, required this.mycards})
      : super(key: key);

  @override
  _DemoReorderableGridState createState() => _DemoReorderableGridState();
}

class _DemoReorderableGridState extends State<DemoReorderableGrid> {
  //final data = List<int>.generate(9, (index) => index);
  double scrollSpeedVariable = 5;

  Widget _buildGrid(BuildContext context) {
    return ReorderableGridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,

      childAspectRatio: 0.6,

      children: getChildren(widget.mycards),

      scrollSpeedController:
          (int timeInMilliSecond, double overSize, double itemSize) {
        if (timeInMilliSecond > 1500) {
          scrollSpeedVariable = 15;
        } else {
          scrollSpeedVariable = 5;
        }
        return scrollSpeedVariable;
      },
      // option
      onDragStart: (dragIndex) {
        print("onDragStart $dragIndex");
      },
      onReorder: (oldIndex, newIndex) {
        // print("reorder: $oldIndex -> $newIndex");
        setState(() {
          final element = widget.mycards.removeAt(oldIndex);
          widget.mycards.insert(newIndex, element);

          CollectionReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('Notes');
          int index = min(oldIndex, newIndex);
          for (int i = index; i < widget.mycards.length; i++) {
            noteModel dataDoc = widget.mycards.elementAt(i).noteData;
            dataDoc.position = i;

            db.doc(dataDoc.id).update({'position': i}).then((_) {
              print('Document updated');
            }).catchError((error) {
              print("\n\n\n---------\n");
              print("\t\t\t {!!!!!!! $error}");
              print("\n\n\n---------\n");
            });
          }
          db.orderBy('position', descending: false);
        });
      },
      // option
      dragWidgetBuilder: (index, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0), child: _buildGrid(context));
  }

  Widget buildItem(noteCard card, int index) {
    return Card(
      elevation: 0.0,
      key: ValueKey(index),
      child: card,
    );
  }

  List<Widget> getChildren(List<noteCard> mycards) {
    List<Widget> C = List<Widget>.empty(growable: true);
    for (int i = 0; i < mycards.length; i++) {
      C.add(buildItem(mycards.elementAt(i), i));
    }
    return C;
  }
}
