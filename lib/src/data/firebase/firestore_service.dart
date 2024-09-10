import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> addDocument(String collectionPath, Map<String, dynamic> data,
      {String? documentId}) async {
    DocumentReference docRef;
    if (documentId != null) {
      docRef = _db.collection(collectionPath).doc(documentId);
      await docRef.set(data); // Set data with specified document ID
    } else {
      docRef = await _db.collection(collectionPath).add(data);
    }
    return docRef.id;
  }

  Future<Map<String, dynamic>?> getDocument(String collectionPath, String documentId) async {
    DocumentSnapshot docSnapshot = await _db.collection(collectionPath).doc(documentId).get();
    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>?;
    }
    return null;  // Return null if document does not exist
  }

  Future<List<DocumentSnapshot>> fetchDocuments(String collectionPath) async {
    QuerySnapshot snapshot = await _db.collection(collectionPath).get().timeout(
      const Duration(seconds: 20),
    );
    return snapshot.docs;
  }

  Stream<DocumentSnapshot> streamDocument(String documentPath) {
    return _db.doc(documentPath).snapshots();
  }

  Stream<List<DocumentSnapshot>> streamCollection(String collectionPath) {
    return _db
        .collection(collectionPath)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}