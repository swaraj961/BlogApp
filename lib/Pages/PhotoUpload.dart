import 'package:blog_app/Pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class UploadPhoto extends StatefulWidget {
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  String _myvalue;
  String url;
  File sampleImage;
   bool showspinner = false;
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

  void uploadImageStatus() async {
    if (validateAndSave()) {
      // *putting reference to store images in database
setState(() {
    showspinner = true ;
});
      final StorageReference postImageReference =
          FirebaseStorage.instance.ref().child("Post Images");
      var timekey = DateTime.now();
      final StorageUploadTask uploadTask = postImageReference
          .child(timekey.toString() + ".jpg")
          .putFile(sampleImage);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      print('ImageUrl is' + url);
setState(() {
    showspinner = false ;
});
      goToHomepage();
      savetoDatabase(url);
    }
  }

  void savetoDatabase(url) {
    var dbTimekey = DateTime.now();
    var formatDate = DateFormat('MMM d,yyyy');
    var formatTime = DateFormat('EEEE,hh:mm aaa');

// *To get the date and time seprately in flutter

    String date = formatDate.format(dbTimekey);
    String time = formatTime.format(dbTimekey);

    // *Creating database reference

    DatabaseReference reference = FirebaseDatabase.instance.reference();

    // *data object map
    var data = {
      "image": url,
      "desciption": _myvalue,
      "date": date,
      "time": time,
    };
    reference.child("Posts").push().set(data);
  }

  void goToHomepage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
        SuccessAlertBox(
              context: context,
              title: "Blog",
              messageText: "Uploaded succesfully");
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
                  onChanged: (value) {
                    setState(() {
                      _myvalue = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                onPressed: uploadImageStatus,
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
    return ModalProgressHUD(
inAsyncCall: showspinner,
          child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('Upload Image'),
          centerTitle: true,
        ),
        body: Center(
          child: sampleImage == null ? Text('Select an image') : enableUpload(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Add Image',
          onPressed: getImage,
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
