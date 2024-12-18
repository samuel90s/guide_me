import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guide_me/Provider/favorite_provider.dart';
import 'package:guide_me/model/category.dart';
import 'package:guide_me/view/login_screen.dart';
import 'package:guide_me/view/main_screen.dart';
import 'package:guide_me/model/place_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// Category and Place models
// import 'package:guide_me/model/category_model.dart';
// import 'package:guide_me/model/place_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadDataInFirebase(),
    );
  }
}

class UploadDataInFirebase extends StatelessWidget {
  const UploadDataInFirebase({super.key});

  Future<void> uploadAllData() async {
    try {
      // Run both save functions in parallel
      await Future.wait([
        saveCategoryItems(),
        savePlacesToFirebase(),
      ]);
      print("Data uploaded successfully!");
    } catch (e) {
      print("Error uploading data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            uploadAllData(); // Call the upload function
          },
          child: const Text("Upload Data"),
        ),
      ),
    );
  }
}

// Function to save category items
Future<void> saveCategoryItems() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("AppCategory");
  for (final category in categoriesList) {
    final String id = DateTime.now().millisecondsSinceEpoch.toString();
    await ref.doc(id).set(category.toMap());
  }
}

// Function to save places
Future<void> savePlacesToFirebase() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("myAppCpollection");
  for (final place in listOfPlace) {
    final String id = DateTime.now().millisecondsSinceEpoch.toString();
    await ref.doc(id).set(place.toMap());
  }
}
