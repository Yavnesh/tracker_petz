import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_kidz/add_petz/new_pet_details.dart';
import 'package:tracker_kidz/database/myPets.dart';
import 'package:tracker_kidz/database/vets_db.dart';
import 'package:tracker_kidz/learn/learn_pet.dart';
import 'package:tracker_kidz/pet_description/pet_description_screen.dart';
import 'package:tracker_kidz/profile/profile_screen.dart';
import 'package:tracker_kidz/vet_description/vet_description.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color kPrimaryColor = Color(0xFFEA5C2B);
  Color kPrimaryLightColor = Color(0xFFFFC6A9);
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: kPrimaryColor,
        title: Text(
          'Welcome',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // bottom: _buildBottomBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AddPet())) ;},
        child: Text("+", style: TextStyle(fontSize: 28),),
        backgroundColor: Color(0xFFEA5C2B),
      ),
      body: Container(
        color: kPrimaryLightColor,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Text(
                "Learn Pets",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            LearnPetLists(),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Text(
                "My Pets",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 150,
              margin: EdgeInsets.only(top: 15),
              child: StreamBuilder<QuerySnapshot>(
                  stream: MyPetsDatabase.readUserPets(userId),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.redAccent)),
                      );
                    }
                    return ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!.docs.map((document) {
                          return _myPetsList(context, document);
                        }).toList());
                  })
            ),
            Container(
              width: double.infinity,
              // color: Colors.grey.shade300,
              height: 60.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Vets Near Me",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height/2,
                margin: EdgeInsets.only(top: 15),
                child: StreamBuilder<QuerySnapshot>(
                    stream: VetsDatabase.readAllVets(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.redAccent)),
                        );
                      }
                      return ListView(

                          children: snapshot.data!.docs.map((document) {
                            return _vetsList(context, document);
                          }).toList());
                    })
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _myPetsList(BuildContext context, document) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PetDescriptionScreen(document: document)));
      },
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(document['pet_image']),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              color: kPrimaryColor,
              child: Text(
                document['pet_name'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _vetsList(BuildContext context, document) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> VetDescriptionScreen(document: document)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(document['Image']),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 100,
              height: 100,
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(document['Name'],
                              style: TextStyle(
                                // color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Text(document['Location'],
                              style: TextStyle(
                                // color: Colors.white,
                                fontSize: 16.0,
                                // fontWeight: FontWeight.bold
                              ),)
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.assistant_direction),
                        onPressed: () {
                          print('tapped');
                        },
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// class NearbyVetsListItem extends StatelessWidget {
//   final Function onPressed;
//   const NearbyVetsListItem({Key? key, required this.onPressed}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: MyPetsDatabase.readUserPets(userId),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(
//                   valueColor:
//                   AlwaysStoppedAnimation<Color>(Colors.redAccent)),
//             );
//           }
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//           child: MaterialButton(
//             padding: const EdgeInsets.all(0),
//             elevation: 0.5,
//             color: Colors.white,
//             clipBehavior: Clip.antiAlias,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => VetDescriptionScreen()));
//             },
//             child: Row(
//               children: <Widget>[
//                 Ink(
//                   height: 100,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     image: DecorationImage(
//                       image: NetworkImage("https://image.freepik.com/free-vector/aquarium-with-single-golden-fish_1284-18775.jpg"),
//                       fit: BoxFit.cover,
//                       alignment: Alignment.center,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Text("Name of the center",
//                                   style: TextStyle(
//                                       // color: Colors.white,
//                                       fontSize: 20.0,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text("Address",
//                                   style: TextStyle(
//                                     // color: Colors.white,
//                                       fontSize: 16.0,
//                                       // fontWeight: FontWeight.bold
//                                   ),)
//                               ],
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.assistant_direction),
//                             onPressed: () {
//                               print('tapped');
//                             },
//                           )
//                         ],
//                       )),
//                 )
//               ],
//             ),
//           ),
//         );
//       }
//     );
//   }
// }

class LearnPetListItem {
  final String? title;
  final String? image;

  LearnPetListItem(
      {this.title,
        this.image});
}

class LearnPetLists extends StatelessWidget {
  final List<LearnPetListItem> _data = [
    LearnPetListItem(
        title: 'Dogs',
        image:
        "https://image.freepik.com/free-photo/cute-smiley-dog-holding-empty-banner_23-2148865723.jpg"),
    LearnPetListItem(
        title: 'Cats',
        image:
        "https://image.freepik.com/free-photo/closeup-shot-ginger-kitten-with-green-eyes-white-background_181624-29784.jpg"),
    LearnPetListItem(
        title: 'Fish',
        image:
        "https://image.freepik.com/free-photo/halfmoon-betta-fish_1150-7898.jpg"),
    // LearnPetListItem(
    //     title: 'Godabari',
    //     image:
    //     "https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
    // LearnPetListItem(
    //     title: 'Rara National Park',
    //     image:
    //     "https://images.pexels.com/photos/1319515/pexels-photo-1319515.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.only(top: 15, left: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          LearnPetListItem item = _data[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LearnPets(type: item.title!)));
            },
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                      image: DecorationImage(
                          image: NetworkImage(item.image!), fit: BoxFit.cover)),
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(item.title!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
              ],
            ),
          );
        },
      ),
    );
  }
}