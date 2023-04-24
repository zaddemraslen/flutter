import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:the_notebook/models/blockModel.dart';

class blockProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<BlockModel> _blocks = [];
  List<BlockModel> get blocks => _blocks;

  Future getAllDocuments() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collectionGroup('test').get();

    snapshot.docs.forEach((doc) async {
      BlockModel block = BlockModel.fromDocumentSnapshot(doc);

      //liste des blocks
      _blocks.add(block);
/*
      CollectionReference notes = doc.reference.collection('Notes');
      QuerySnapshot querySnapshot = await notes.get();
      if (querySnapshot.docs.isNotEmpty) {
        // "Notes" collection is empty
        //TODO how to deal with notes ?
      }*/
    });
    _blocks.sort((a, b) => a.rank.compareTo(b.rank));
  }
}
