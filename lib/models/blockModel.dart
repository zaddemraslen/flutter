import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_notebook/models/myNoteModel.dart';

class BlockModel {
  String id;
  String title;
  String urlImg;
  int position;
  int rank;
  List<myNoteModel> notes = [];

  BlockModel({
    required this.id,
    required this.title,
    required this.urlImg,
    required this.position,
    required this.rank,
  });

  BlockModel.fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc)
      : this(
          id: doc.id,
          title:
              (doc.data() as Map<String, dynamic>)['title']?.toString() ?? '',
          urlImg:
              (doc.data() as Map<String, dynamic>)['urlImg']?.toString() ?? '',
          position:
              (doc.data() as Map<String, dynamic>)['position'] as int? ?? 0,
          rank: (doc.data() as Map<String, dynamic>)['rank'] as int? ?? 0,
        );

  @override
  String toString() {
    String str = 'BlockModel{id: $id, title: $title, urlImg: $urlImg, '
        'position: $position, rank: $rank , notes: $notes }';
    return str;
  }
}
