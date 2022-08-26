import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('users');

class UsersDatabase {
  static Future<void> addUser({
    String? userId,
    String? user_name,
    String? user_location,
    String? user_email,
    String? user_contact,
    String? user_about,
    String? user_image,
  }) async {
    DocumentReference documentReference =
    _userCollection.doc(DateTime.now().millisecondsSinceEpoch.toString());

    Map<String, dynamic> data = <String, dynamic>{
      "userId": userId,
      "user_name": user_name,
      "user_location": user_location,
      "user_email": user_email,
      "user_contact": user_contact,
      "user_about": user_about,
      "user_image": user_image,
      "time_stamp": DateTime.now().millisecondsSinceEpoch.toString()
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("User added to database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readUser(uid) {
    String? userId = uid;
    return FirebaseFirestore.instance
        .collection('users').where('userId', isEqualTo: userId).snapshots();
  }
}