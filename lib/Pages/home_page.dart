import 'package:firebase_flutter/Utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth auth = Auth();
  String name, photo;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    getInfo();
  }

  void getInfo() async {
    FirebaseUser user = await auth.getCurrentUser();
    setState(() {
      name = user.displayName;
      photo = user.photoUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: height / 2.5,
          width: width,
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  color: Colors.teal,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: width / 2,
                  width: width / 2,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 5.0,
                          style: BorderStyle.none),
                      borderRadius: BorderRadius.circular(200.0),
                      image: DecorationImage(
                          image: NetworkImage(photo), fit: BoxFit.cover),
                      color: Colors.teal,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 15.0,
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
        Text(
          "Welcome $name",
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 4, size.height - 120, size.width / 2, size.height - 60);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
