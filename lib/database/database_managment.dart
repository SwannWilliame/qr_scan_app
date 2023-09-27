import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; 

class Database{
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("ids");
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> createId(String id, String name)async{
    collectionReference.doc(id).set({
      "name": name,
    });
  }

  Future<bool> docCheck(String docId) async {
    try {
      var doc = await collectionReference.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<List<DocumentSnapshot>> getAllDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('ids').get();
    return querySnapshot.docs;
  }

  Future<void> removeDocument(String id)async{
    collectionReference.doc(id).delete();
  }
}