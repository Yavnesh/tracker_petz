import 'package:flutter/material.dart';

class VetDescriptionScreen extends StatelessWidget {
  Color kPrimaryColor = Color(0xFFEA5C2B);
  Color kPrimaryLightColor = Color(0xFFFFC6A9);
  final document;
  VetDescriptionScreen({Key? key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.5, 0.9],
                    colors: [kPrimaryColor, kPrimaryColor])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(
                        Icons.call,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      minRadius: 30.0,
                      backgroundColor: kPrimaryLightColor,
                    ),
                    CircleAvatar(
                      minRadius: 60,
                      backgroundColor: Colors.deepOrange.shade300,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(document['Image']),
                        minRadius: 50,
                      ),
                    ),
                    CircleAvatar(
                      child: Icon(
                        Icons.message,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      minRadius: 30.0,
                      backgroundColor: kPrimaryLightColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  document['Name'],
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                Text(
                  document['Location'],
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            // height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.deepOrange.shade300,
                    child: ListTile(
                      title: Text(
                        "Opens At",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                      subtitle: Text(
                        document['Open At'],
                        textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.deepOrange.shade300,
                    child: ListTile(
                      title: Text(
                        "Closes At",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                      subtitle: Text(
                        document['Closes At'],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Description",
              style: TextStyle(color: Colors.deepOrange, fontSize: 16.0),
            ),
            subtitle: Text(
              document['Description'],
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "Phone",
              style: TextStyle(color: Colors.deepOrange, fontSize: 16.0),
            ),
            subtitle: Text(
              document['Phone Number'],
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Divider(),
          // ListTile(
          //   title: Text(
          //     "Twitter",
          //     style: TextStyle(color: Colors.deepOrange, fontSize: 16.0),
          //   ),
          //   subtitle: Text(
          //     "@ramkumar",
          //     style: TextStyle(fontSize: 20.0),
          //   ),
          // ),
          // Divider(),
          // ListTile(
          //   title: Text(
          //     "Facebook",
          //     style: TextStyle(color: Colors.deepOrange, fontSize: 16.0),
          //   ),
          //   subtitle: Text(
          //     "facebook.com/ramkumar",
          //     style: TextStyle(fontSize: 20.0),
          //   ),
          // ),
          // Divider(),
        ],
      ),
    );
  }
}