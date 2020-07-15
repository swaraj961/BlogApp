import 'package:blog_app/Pages/auth.dart';
import 'package:blog_app/Pages/login.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

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

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
      SuccessBgAlertBox(
          context: context,
          title: "You have been logout",
          infoMessage: 'Login to continue');
    } catch (e) {
      print("Error is " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Container(),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        items: <Widget>[
          IconButton(
              icon: Icon(
                Icons.file_upload,
                size: 30,
                color: Colors.white,
              ),
              onPressed: null),
          IconButton(
              icon: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              onPressed: null),
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
}
