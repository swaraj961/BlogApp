import 'package:blog_app/Pages/auth.dart';
import 'package:blog_app/Pages/mapping.dart';
import 'package:flutter/material.dart';

void main() => runApp(BlogApp());

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlogApp',
      theme: ThemeData(
        // primarySwatch: Colors.purple,
        primaryColor: Color(0xff00BFA6),
      ),
      home: Mapping(
        authentication: Authentication(),
      ),
    );
  }
}
