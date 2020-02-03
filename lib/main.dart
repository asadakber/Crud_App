import 'package:flutter/material.dart';
import 'package:todo_app_firebase/screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Crud App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      home: HomePage(),
//        home: Text('Hello World!'),
    );
  }
}
