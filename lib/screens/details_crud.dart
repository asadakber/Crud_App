import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_firebase/modal/crud.dart';

class DetailsCrud extends StatelessWidget {

  final Crud crud;

  DetailsCrud({Key key, this.crud}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Crud'),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(crud.title, style: Theme.of(context).textTheme.title.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),),
            SizedBox(height: 20.0),
            Text(crud.description, style: TextStyle(
              fontSize: 16.0
            ),)
          ],
        ),
      ),
    );
  }
}
