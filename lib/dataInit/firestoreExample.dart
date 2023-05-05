import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreExample extends StatefulWidget {
  @override
  _FirestoreExampleState createState() => _FirestoreExampleState();
}

class _FirestoreExampleState extends State<FirestoreExample> {
  final CollectionReference radiosCollection =
      FirebaseFirestore.instance.collection('radios');

  Future<void> addRadiosToFirestore() async {
    // Read the JSON data from the file
    final jsonFileData = await DefaultAssetBundle.of(context)
        .loadString('assets/dummyData.json');

    // Parse the JSON data into a List<Map<String, dynamic>>
    final List<Map<String, dynamic>> radiosJson =
        List<Map<String, dynamic>>.from(json.decode(jsonFileData)['radios']);

    // Create a Firestore document for each radio object and add it to the "radios" collection
    radiosJson.forEach((radioJson) async {
      await radiosCollection.add(radioJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: addRadiosToFirestore,
          child: Text('Add Radios to Firestore'),
        ),
      ),
    );
  }
}
