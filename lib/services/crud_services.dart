import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_firebase/modal/crud.dart';

class CrudServices {
  static final CrudServices _crudServices = CrudServices._internal();

  Firestore _db = Firestore.instance;

  CrudServices._internal();

  factory CrudServices() {
    return _crudServices;
  }

  Stream<List<Crud>> getCrud() {
    return _db.collection('crud').snapshots().map(
        (snapshot) => snapshot.documents.map(
            (doc) => Crud.fromMap(doc.data, doc.documentID)
        ).toList()
    );
  }

  Future<void> addCrud(Crud crud) {
    return _db.collection('crud').add(crud.toMap());
  }

  Future<void> update(Crud crud) {
    return _db.collection('crud').document(crud.id).updateData(crud.toMap());
  }

  Future<void> delete(String id) {
    return _db.collection('crud').document(id).delete();
  }

}