import 'package:flutter/material.dart';
import 'package:the_notebook/models/blockModel.dart';
import 'package:the_notebook/style/app_style.dart';

class blockCard extends StatefulWidget {
  final BlockModel blockData;
  /* class BlockModel {
  String id;
  String title;
  String urlImg;
  int position;
  int rank;
  List<myNoteModel> notes = [];
 */
  //final Function()? onTap;

  blockCard(
      {super.key, /*required this.onTap,*/ required BlockModel this.blockData});

  @override
  State<blockCard> createState() => _blockCardState();
}

class _blockCardState extends State<blockCard> {
  bool validBgImg = true;
  late ImageProvider bgImg;

  Future<ImageProvider> checkImage() async {
    if (widget.blockData.urlImg.startsWith('http')) {
      // Remote image file
      return NetworkImage(widget.blockData.urlImg);
    } else {
      // Local image file
      return AssetImage('assets/utilities/abstract.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageProvider>(
      future: checkImage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            //onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: snapshot.data!,
                  fit: BoxFit.cover,
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
                        ((widget.blockData.rank + 1).toString()).toString(),
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
                    child: Center(
                      child: Text(
                        widget.blockData.title,
                        style: AppStyle.mainTitle,
                      ),
                    ),
                  ),
                ],
              ),
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
                        (widget.blockData.rank.toString()).toString(),
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
