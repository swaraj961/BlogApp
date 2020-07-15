import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPhoto extends StatefulWidget {
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  File sampleImage;
  final formkey = GlobalKey<FormState>();

  Future getImage() async {
    var tempImage = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage as File;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null ? Text('Select an image') : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Image',
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

Widget enableUpload() {
  return Form(child: null);
}
