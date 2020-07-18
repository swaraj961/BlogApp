import 'package:blog_app/Pages/PhotoUpload.dart';
import 'package:blog_app/Pages/auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'Models/post.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  final Authentication auth;
  final VoidCallback onSignedOut;

  const HomePage({Key key, this.auth, this.onSignedOut}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;

  void logoutUser() async {
    try {
      await widget.auth.signout();
      widget.onSignedOut();

      SuccessBgAlertBox(
          context: context,
          title: "You have been logout",
          infoMessage: 'Login to continue');
    } catch (e) {
      print("Error is " + e.toString());
    }
  }

  List<Posts> postfeed = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference postRef =
        FirebaseDatabase.instance.reference().child('Posts');
    postRef.once().then(
      (DataSnapshot snapdata) {
        postfeed.clear();

        Map<dynamic, dynamic> values = snapdata.value;
        values.forEach((key, values) {
          Posts posts = Posts(
            values['date'],
            values['desciption'],
            values['image'],
            values['time'],
          );
          // print(values["image"]);
          // print(values['desciption']);
          // print(values["time"]);
          // print(values["date"]);
          postfeed.add(posts);
          setState(() {});
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Container(
        child: postfeed.length == 0
            ? Center(
                child: Text(
                'No blog available',
                style: Theme.of(context).textTheme.bodyText1,
              ))
            : ListView.builder(
                itemCount: postfeed.length,
                itemBuilder: (context, index) {
                  return PostUI(
                      postfeed[index].image,
                      postfeed[index].description,
                      postfeed[index].date,
                      postfeed[index].time);
                }),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        items: <Widget>[
          IconButton(
              icon: Icon(
                Icons.rss_feed,
                size: 30,
                color: Colors.white,
              ),
              onPressed: null),
          IconButton(
              icon: Icon(
                Icons.file_upload,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadPhoto(),
                  ),
                );
              }),
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              size: 30,
              color: Colors.white,
            ),
            onPressed: logoutUser,

            // ConfirmAlertBox(
            //   context: context,
            //   title: "You will be logout",
            //   infoMessage: "Do you want to proceed ?",
            //   onPressedYes: logoutUser,
            // );
          ),
        ],
        onTap: (index) {
          _page = index;
        },
      ),
    );
  }

  Widget PostUI(String image, String description, String date, String time) {
    return Card(
      elevation: 12.0,
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                   
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                   
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                description,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
