import 'package:flutter/material.dart';

class LearnPets extends StatefulWidget {
  final type;
  const LearnPets({Key? key, this.type}) : super(key: key);

  @override
  _LearnPetsState createState() => _LearnPetsState();
}

class _LearnPetsState extends State<LearnPets> {
  final List<String> images = [
    "https://res.cloudinary.com/assistus/image/upload/v1639074638/TrackerPetz/onboarding_image_x9yi2m.png",
    "https://res.cloudinary.com/assistus/image/upload/v1639074638/TrackerPetz/onboarding_image_x9yi2m.png",
    "https://res.cloudinary.com/assistus/image/upload/v1639074638/TrackerPetz/onboarding_image_x9yi2m.png",
    "https://res.cloudinary.com/assistus/image/upload/v1639074638/TrackerPetz/onboarding_image_x9yi2m.png",
    "https://res.cloudinary.com/assistus/image/upload/v1639074638/TrackerPetz/onboarding_image_x9yi2m.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEA5C2B),
        title: Text("Learn all about " + widget.type),
      ),
      body: Container(
        color: Color(0xFFFFC6A9),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: images
                      .map((item) => Card(
                    color: Colors.white,
                    elevation: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.cover)),
                      child: Transform.translate(
                        offset: Offset(80, -80),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 80),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ))
                      .toList(),
                )),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
