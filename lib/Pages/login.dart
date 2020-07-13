import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// * to differnciate b/w the login and register page
enum FormType { login, register }

class _LoginScreenState extends State<LoginScreen> {
  // * to get the form login state
  final formkey = new GlobalKey<FormState>();
  void validateAndSave() {}

  void moveToRegister() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BlogApp'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(15),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: createInput() + createButton(),
                ),
              )),
        ));
  }

// *Creating a function to return basically list of widget in the form
  List<Widget> createInput() {
    return [
      SizedBox(
        height: 10,
      ),
      logo(),
      Center(
        child: Text(
          'Welcome',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 30),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      TextFormField(
        decoration:
            InputDecoration(labelText: 'Email', hintText: 'Enter your Email'),
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        decoration: InputDecoration(
            labelText: 'Password', hintText: 'Enter your password'),
      ),
      SizedBox(
        height: 10,
      ),
    ];
  }

  Widget logo() {
    return Hero(
      tag: 'logo',
      child: Container(
        margin: EdgeInsets.all(10),
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/logoapp.png'),
        )),
      ),
    );
  }

  List<Widget> createButton() {
    return [
      SizedBox(
        height: 10,
      ),
      RaisedButton(
        color: Colors.green,
        textColor: Colors.white,
        child:
            Text('Login', style: TextStyle(fontSize: 20, color: Colors.white)),
        onPressed: validateAndSave,
      ),
      SizedBox(
        height: 5,
      ),
      RaisedButton(
        color: Colors.red,
        textColor: Colors.white,
        child: Text('New? Create a Account',
            style: TextStyle(fontSize: 14, color: Colors.white)),
        onPressed: moveToRegister,
      )
    ];
  }
}
