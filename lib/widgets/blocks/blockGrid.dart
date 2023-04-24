import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:the_notebook/models/blockModel.dart';

import 'block_card.dart';

class blockGrid extends StatefulWidget {
  final List<blockCard> myblocks;

  const blockGrid({Key? key, required this.myblocks}) : super(key: key);

  @override
  _blockGridState createState() => _blockGridState();
}

class _blockGridState extends State<blockGrid> {
  double scrollSpeedVariable = 5;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildGrid(BuildContext context) {
    print("pssssst");

    if (widget.myblocks == null) {
      return Center(child: Text("empty"));
    }

    return ReorderableGridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,

      childAspectRatio: 0.6,

      children: getChildren(widget.myblocks),

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
          final element = widget.myblocks.removeAt(oldIndex);
          widget.myblocks.insert(newIndex, element);

          CollectionReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('test');
          int index = min(oldIndex, newIndex);
          for (int i = index; i < widget.myblocks.length; i++) {
            BlockModel dataDoc = widget.myblocks.elementAt(i).blockData;
            dataDoc.rank = i;

            db.doc(dataDoc.id).update({'rank': i}).then((_) {
              print('Document updated');
            }).catchError((error) {
              print("\n\n\n---------\n");
              print("\t\t\t {!!!!!!! $error}");
              print("\n\n\n---------\n");
            });
          }
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
    print("\n\n\n------here--------------------\n");
    print(widget.myblocks);
    print(widget.myblocks.length);
    widget.myblocks.forEach((card) {
      print(card.blockData.title);
    });
    print("\n------here--------------------\n\n\n");

    if (widget.myblocks == null || widget.myblocks.isEmpty) {
      return Center(child: Text("empty block list"));
    }

    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0), child: _buildGrid(context));
  }

  Widget buildItem(blockCard card, int index) {
    return Card(
      elevation: 0.0,
      key: ValueKey(index),
      child: card,
    );
  }

  List<Widget> getChildren(List<blockCard> myblocks) {
    List<Widget> C = List<Widget>.empty(growable: true);
    for (int i = 0; i < myblocks.length; i++) {
      C.add(buildItem(myblocks.elementAt(i), i));
    }
    return C;
  }
}
