import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_kidz/auth/auth_service.dart';
import 'package:tracker_kidz/auth/login.dart';
import 'package:tracker_kidz/database/user.dart';

class ProfileScreen extends StatelessWidget {
  Color kPrimaryColor = Color(0xFFEA5C2B);
  Color kPrimaryLightColor = Color(0xFFFFC6A9);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final Stream<QuerySnapshot> _stream;
    _stream = UsersDatabase.readUser(userId);
    return StreamBuilder(
        stream: _stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List userDetails = [];
          snapshot.data!.docs.map((e) {
            Map details = e.data() as Map<String, dynamic>;
            userDetails.add(details);
          }).toList();
          return Scaffold(
              backgroundColor: kPrimaryLightColor,
              extendBodyBehindAppBar: true,
              extendBody: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () async {
                        authService.signOut().then((value) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => LoginScreen()));
                        });
                      },
                      icon: Icon(
                        Icons.power_settings_new_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ProfileHeader(
                      avatar: NetworkImage(
                          userDetails[0]['user_image']),
                      // coverImage: NetworkImage("https://image.freepik.com/free-photo/abstract-grunge-decorative-relief-navy-blue-stucco-wall-texture-wide-angle-rough-colored-background_1258-28311.jpg"),
                      title: userDetails[0]['user_name'],
                      subtitle: "Pet Owner",
                      // actions: <Widget>[
                      //   MaterialButton(
                      //     color: Colors.white,
                      //     shape: CircleBorder(),
                      //     elevation: 0,
                      //     child: Icon(Icons.edit),
                      //     onPressed: () {},
                      //   )
                      // ],
                    ),
                    const SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "User Information",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Card(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              ...ListTile.divideTiles(
                                color: Colors.grey,
                                tiles: [
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    leading: Icon(
                                      Icons.my_location,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text("Location"),
                                    subtitle: Text(userDetails[0]['user_location']),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.email,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text("Email"),
                                    subtitle: Text(userDetails[0]['user_email']),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.phone,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text("Phone"),
                                    subtitle: Text(userDetails[0]['user_contact']),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text("About Me"),
                                    subtitle: Text(
                                        userDetails[0]['user_about']),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
                  ],
                ),
              ));
        });

  }
}

class ProfileHeader extends StatelessWidget {
  // final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const ProfileHeader(
      {Key? key,
      // required this.coverImage,
      required this.avatar,
      required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color kPrimaryColor = Color(0xFFEA5C2B);
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          color: kPrimaryColor,
          // decoration: BoxDecoration(
          //   image: DecorationImage(image: coverImage as ImageProvider<Object>, fit: BoxFit.cover),
          // ),
        ),
        // Ink(
        //   height: 200,
        //   decoration: BoxDecoration(
        //     color: Colors.black38,
        //   ),
        // ),
        if (actions != null)
          Container(
            color: kPrimaryColor,
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color? backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key? key,
      required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image as ImageProvider<Object>?,
        ),
      ),
    );
  }
}
