import 'package:RadioWave/models/radiom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RadioWave/style/app_style.dart';

class RadioCard extends StatefulWidget {
  final RadioM radioData;

  RadioCard({super.key, required RadioM this.radioData});

  @override
  State<RadioCard> createState() => _RadioCardState();
}

class _RadioCardState extends State<RadioCard> {
  bool validBgImg = true;
  late ImageProvider bgImg;

  Future<ImageProvider> checkImage() async {
    if (widget.radioData.image.startsWith('http')) {
      return NetworkImage(widget.radioData.image);
    } else {
      return AssetImage('assets/utilities/abstract.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageProvider>(
      future: checkImage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.all(0.0),
            margin: const EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: snapshot.data!,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      topRight: Radius.circular(6.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (widget.radioData.tagline),
                      style: AppStyle.mainTitle,
                    ),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  child: Text(""),
                )),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6.0),
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20.0),
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.radioData.category,
                            style: AppStyle.mainTitle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          final DocumentReference docRef = firestore
                              .collection('radios')
                              .doc(widget.radioData.id);
                          await docRef.update({
                            'isDisliked': !widget.radioData.disliked,
                          });
                          // Code to execute when the icon is tapped
                          setState(() {
                            widget.radioData.disliked =
                                !widget.radioData.disliked;
                            print('Icon tapped');
                          });
                        },
                        child: Icon(
                          widget.radioData.disliked == false
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined,
                          color: AppStyle.accentColor2,
                          size: 35.0,
                        ),
                      ),
                      SizedBox(width: 15.0),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return InkWell(
            //onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/utilities/abstract.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //height: 30.0,
                    //width: 30.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        (widget.radioData.order.toString()).toString(),
                        style: AppStyle.mainTitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text(
            "ERROR",
            style: TextStyle(color: Colors.white),
          );
        }
      },
    );
  }
}
