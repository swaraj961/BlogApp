import 'package:blog_app/Pages/homepage.dart';

import 'package:flutter/material.dart';
import 'login.dart';

import 'auth.dart';

class Mapping extends StatefulWidget {
  final Authentication authentication;

  Mapping({Key key, this.authentication}) : super(key: key);

  @override
  _MappingState createState() => _MappingState();
}

enum AuthStatus {
  notSignedin,
  signedin,
}

class _MappingState extends State<Mapping> {
  AuthStatus authStatus = AuthStatus.notSignedin;

  @override
  void initState() {
    widget.authentication.getCurrentUser().then((value) {
      setState(() {
        authStatus =
            value == null ? AuthStatus.notSignedin : AuthStatus.signedin;
      });
    });
    super.initState();
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedin;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedin;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedin:
        return LoginScreen(
          auth: widget.authentication,
          onSignedIn: _signedIn,
        );

      case AuthStatus.signedin:
        return HomePage(
          auth: widget.authentication,
          onSignedOut: _signedOut,
        );
    }

    return null;
  }
}
