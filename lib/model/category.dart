import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

// to upload data in firebase
Future<void> saveCategoryItems() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("AppCategory");
  for (final Category category in categoriesList) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");
    await ref.doc(id).set(category.toMap());
  }
}

class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
  // to upload data in firebase
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
    };
  }
}
final List<Category> categoriesList = [
  Category(
    title: "Destinations",
    image: "https://cdn-icons-png.flaticon.com/512/684/684908.png", // Location icon
  ),
  Category(
    title: "Accommodations",
    image: "https://cdn-icons-png.flaticon.com/512/201/201514.png", // Hotel icon
  ),
  Category(
    title: "Events",
    image: "https://cdn-icons-png.flaticon.com/512/753/753252.png", // Calendar icon
  ),
  Category(
    title: "Transportation",
    image: "https://cdn-icons-png.flaticon.com/512/2284/2284818.png", // Bus/Travel icon
  ),
  Category(
    title: "Culinary",
    image: "https://cdn-icons-png.flaticon.com/512/3075/3075977.png", // Food icon
  ),
  Category(
    title: "Culture",
    image: "https://cdn-icons-png.flaticon.com/512/4763/4763431.png", // Culture/Dance icon
  ),
  Category(
    title: "Activities",
    image: "https://cdn-icons-png.flaticon.com/512/1177/1177831.png", // Sports/Outdoor activities icon
  ),
  Category(
    title: "Shopping",
    image: "https://cdn-icons-png.flaticon.com/512/3135/3135706.png", // Shopping bag icon
  ),
];
