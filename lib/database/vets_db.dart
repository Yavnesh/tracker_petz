

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _vetsCollection = _firestore.collection('Vets');

class VetsDatabase {
  static Stream<QuerySnapshot> readAllVets() {

    return FirebaseFirestore.instance
        .collection('Vets').snapshots();
  }

}