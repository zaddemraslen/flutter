import 'dart:math';

import 'package:RadioWave/models/radiom.dart';
import 'package:RadioWave/widgets/radioCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:RadioWave/style/app_style.dart';
import 'package:audioplayers/audioplayers.dart';

class RadioGrid extends StatefulWidget {
  final List<RadioCard> myradios;

  const RadioGrid({Key? key, required this.myradios}) : super(key: key);

  @override
  _RadioGridState createState() => _RadioGridState();
}

class _RadioGridState extends State<RadioGrid> {
  AudioPlayer audioPlayer = AudioPlayer();
  double scrollSpeedVariable = 5;
  int? _activeIndex;
  final List<String> urls = [];

  void _setActiveIndex(int index) {
    if (_activeIndex == null || _activeIndex != index) {
      // If a different radio card was clicked, set it as the active index.
      _activeIndex = index;
    } else {
      // If the active index is already the same as the clicked index,
      // toggle the play/pause state of the radio card.
      _activeIndex = null;
    }
    setState(() {});
  }

  @override
  void initState() {
    _activeIndex = null;
    widget.myradios.forEach((element) {
      urls.add(element.radioData.url);
    });
    super.initState();
  }

  Widget _buildGrid(BuildContext context) {
    if (widget.myradios == null) {
      return Center(child: Text("empty"));
    }

    return ReorderableGridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 1,

      //childAspectRatio: 0.6,

      children: getChildren(widget.myradios),

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
        print("reorder: $oldIndex -> $newIndex");
        setState(() {
          final element = widget.myradios.removeAt(oldIndex);
          widget.myradios.insert(newIndex, element);
          _activeIndex = newIndex;
          CollectionReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('radios');
          int index = min(oldIndex, newIndex);
          for (int i = index; i < widget.myradios.length; i++) {
            RadioM dataDoc = widget.myradios.elementAt(i).radioData;
            dataDoc.order = i;

            db.doc(dataDoc.id).update({'order': i}).then((_) {
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
    if (widget.myradios == null || widget.myradios.isEmpty) {
      return Center(
          child: Text(
        "Empty radio list",
        style: AppStyle.inf,
      ));
    }

    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0), child: _buildGrid(context));
  }

  Widget buildItem(RadioCard card, int index) {
    return Card(
      elevation: 0.0,
      key: ValueKey(index),
      child: Stack(children: [
        card,
        Positioned.fill(
          child: Center(
            child: GestureDetector(
              onTap: () async {
                _setActiveIndex(card.radioData.order);
                if (_activeIndex == null)
                  int result = await audioPlayer.stop();
                else {
                  int indice = _activeIndex ?? -1;
                  if (indice != -1)
                    int result = await audioPlayer.play(card.radioData.url);
                }
                setState(() {});
              },
              child: Container(
                width: 55.0,
                height: 55.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  card.radioData.order == _activeIndex
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 40.0,
                  color: AppStyle.accentColor,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  List<Widget> getChildren(List<RadioCard> myradios) {
    List<Widget> C = List<Widget>.empty(growable: true);
    for (int i = 0; i < myradios.length; i++) {
      C.add(buildItem(myradios.elementAt(i), i));
    }
    return C;
  }
}
