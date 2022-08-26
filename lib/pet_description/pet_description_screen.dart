import 'package:flutter/material.dart';

class PetDescriptionScreen extends StatefulWidget {
  final document;

  const PetDescriptionScreen({Key? key, this.document}) : super(key: key);

  @override
  _PetDescriptionScreenState createState() => _PetDescriptionScreenState();
}

class _PetDescriptionScreenState extends State<PetDescriptionScreen> {
  Color kPrimaryColor = Color(0xFFEA5C2B);
  Color kPrimaryLightColor = Color(0xFFFFC6A9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: BoxDecoration(color: Colors.black26),
              height: 400,
              child: Image.network(widget.document['pet_image'],
                  fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: kPrimaryColor,
                          image: DecorationImage(
                            image: widget.document['pet_type'] == "Dog" ? NetworkImage(
                                "https://image.freepik.com/free-photo/beautiful-pet-portrait-dog_23-2149218499.jpg"):
                            widget.document['pet_type'] == "Cat"? NetworkImage(
                                "https://image.freepik.com/free-photo/shallow-focus-shot-blue-eyed-domestic-short-haired-cat_181624-49986.jpg"):
                            NetworkImage(
                                "https://image.freepik.com/free-photo/selective-shot-aquarium-yellow-cichlidae-fish_181624-35618.jpg")
                            ,
                            fit: BoxFit.cover,
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right : 16.0),
                      child: Text(
                        widget.document['pet_name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .6,
                  padding: const EdgeInsets.all(32.0),
                  color: kPrimaryLightColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Card(
                                      color: kPrimaryColor,
                                      elevation: 5,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: kPrimaryColor,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://image.freepik.com/free-vector/adorable-marine-ajolote-illustration_23-2149221998.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Gender",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                // color: Colors.white
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("Male",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  // color: Colors.white
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: kPrimaryColor,
                                      elevation: 5,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: kPrimaryColor,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://image.freepik.com/free-vector/adorable-marine-ajolote-illustration_23-2149237774.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Weight",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                // color: Colors.white
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("20 KG",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  // color: Colors.white
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: kPrimaryColor,
                                      elevation: 5,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: kPrimaryColor,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://image.freepik.com/free-vector/adorable-marine-ajolote-illustration_23-2149237776.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Species",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("Persian",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  // color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 30.0),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: RaisedButton(
                      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      //     color: kPrimaryColor,
                      //     textColor: Colors.white,
                      //     child: Text("Book Now", style: TextStyle(
                      //         fontWeight: FontWeight.normal
                      //     ),),
                      //     padding: const EdgeInsets.symmetric(
                      //       vertical: 16.0,
                      //       horizontal: 32.0,
                      //     ),
                      //     onPressed: () {},
                      //   ),
                      // ),
                      const SizedBox(height: 30.0),
                      Text(
                        "Description".toUpperCase(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          // color: Colors.white
                        ),
                      ),
                      // const SizedBox(height: 10.0),
                      // Text(
                      //   "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?",
                      //   textAlign: TextAlign.justify,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w300, fontSize: 14.0),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "DETAIL",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
