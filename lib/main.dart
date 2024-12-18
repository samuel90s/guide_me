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

void main() async{
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
      home: UploadDataInfirebase(),
    );
  }
}

class UploadDataInfirebase extends StatelessWidget {
  const UploadDataInfirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            saveCategoryItems(),
            savePlacesToFirebase();
          }, child: Text("Upload Data")),
      ),
    );
  }
}
