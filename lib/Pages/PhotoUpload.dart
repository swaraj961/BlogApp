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
  String _myvalue;
  File sampleImage;
  final picker = ImagePicker();
  final formkey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = File(pickedFile.path);
    });
  }

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.file(
                sampleImage,
                height: 330,
                width: 660,
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    return value.isEmpty ? 'Description in required' : null;
                  },
                  onSaved: (value) {
                    return _myvalue = value;
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                onPressed: validateAndSave,
                elevation: 10,
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                child: Text('Add a new blog'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
