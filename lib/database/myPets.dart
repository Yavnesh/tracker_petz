import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _myPetsCollection = _firestore.collection('myPets');

class MyPetsDatabase {
  static Future<void> addPet({
    String? userId,
    String? pet_name,
    String? pet_species,
    String? pet_description,
    String? pet_weight,
    String? pet_gender,
    String? pet_image,
    String? pet_type,
    DateTime? pet_dob,
  }) async {
    DocumentReference documentReference =
    _myPetsCollection.doc(DateTime.now().millisecondsSinceEpoch.toString());

    Map<String, dynamic> data = <String, dynamic>{
      "userId": userId,
      "pet_name": pet_name,
      "pet_species": pet_species,
      "pet_description": pet_description,
      "pet_weight": pet_weight,
      "pet_gender": pet_gender,
      "pet_image": pet_image,
      "pet_type": pet_type,
      "pet_dob": pet_dob,
      "time_stamp": DateTime.now().millisecondsSinceEpoch.toString()
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("Pet added to database"))
        .catchError((e) => print(e));
  }

  // static Stream<QuerySnapshot> readAllPets(uid) {
  //   String? userId = uid;
  //   return FirebaseFirestore.instance
  //       .collection('myPets').where('userId', isNotEqualTo: userId).snapshots();
  // }

  static Stream<QuerySnapshot> readUserPets(uid) {
    String? userId = uid;
    return FirebaseFirestore.instance
        .collection('myPets').where('userId', isEqualTo: userId).snapshots();
  }

  // static Stream<QuerySnapshot> readRecipesByCategory(category) {
  //   // String? userId = uid;
  //   print(category);
  //   Query collection = FirebaseFirestore.instance.collection('recipes').where('category', isEqualTo: '${category} Recipe');
  //   return collection.snapshots();
  // }
  //
  // static Stream<QuerySnapshot> readSearchRecipes(searchText) {
  //   print(searchText);
  //   print("@@@@@@@@@@@@@@@");
  //   Query collection = FirebaseFirestore.instance.collection('recipes').where("title", isGreaterThanOrEqualTo: searchText);
  //   // collection = collection.where("title", isGreaterThanOrEqualTo: searchText).where("title", isLessThanOrEqualTo: "${searchText}\uf7ff");
  //   return collection.snapshots();
  // }
}