import 'dart:convert';

import 'package:RadioWave/models/radiom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:RadioWave/models/radioMModel.dart';
//import 'package:RadioWave/widgets/content/noteM.dart';

class RadioProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<RadioM> _radioMs = [];
  List<RadioM> get radioMM => _radioMs;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getAllRadio() async {
    _radioMs = [];
    _isLoading = true;
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collectionGroup('radios').get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      RadioM tempRadio = RadioM.fromJson(doc.data() as Map<String, dynamic>);
      tempRadio.id = doc.id;
      _radioMs.add(tempRadio);
    }

    _radioMs.sort((a, b) => a.order.compareTo(b.order));
    _isLoading = false;
    print("oiioioioioioi\n_radioMs\noiioioioioioi");
    notifyListeners();
  }
}
