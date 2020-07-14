import 'package:flutter/material.dart';
import 'auth.dart';

class LoginScreen extends StatefulWidget {
  final Authentication auth;
  final VoidCallback onSignedIn;

  const LoginScreen({Key key, this.auth, this.onSignedIn}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// * to differnciate b/w the login and register page
enum FormType { login, register }

class _LoginScreenState extends State<LoginScreen> {
  // * to get the form login state
  final formkey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  // String _email = "";
  // String _pass = "";
  TextEditingController emailTextEditcontroller = TextEditingController();
  TextEditingController passTextEditcontroller = TextEditingController();

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String email = emailTextEditcontroller.text;
          String password = passTextEditcontroller.text;
          String userid = await widget.auth.signIN(email, password);

          print("Login UserID =" + userid);
        } else {
          String email = emailTextEditcontroller.text;
          String password = passTextEditcontroller.text;
          String userid = await widget.auth.signUP(email, password);

          print("Register UserID =" + userid);
        }
        widget.onSignedIn();
      } catch (e) {
        print("Error is " + e.toString());
      }
    }
  }

  void moveToRegister() {
    // *if user move and get back forms state will be reset
    formkey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    // *if user move and get back forms state will be reset
    formkey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

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
                key: formkey,
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
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Please sign in to continue.',
            style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
                fontSize: 13),
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      TextFormField(
        controller: emailTextEditcontroller,
        validator: (emailid) {
          return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(emailid)
              ? null
              : "Please provide a valid email Id ";
        },
        decoration:
            InputDecoration(labelText: 'Email', hintText: 'Enter your Email'),
        keyboardType: TextInputType.emailAddress,
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        controller: passTextEditcontroller,
        validator: (password) {
          return password.isEmpty || password.length < 6
              ? "password must be 6 or more characters"
              : null;
        },
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
    if (_formType == FormType.login) {
      return [
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          color: Colors.green,
          textColor: Colors.white,
          child: Text('Login',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          onPressed: validateAndSubmit,
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
    } else {
      return [
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          color: Colors.green,
          textColor: Colors.white,
          child: Text('Create an account',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          onPressed: validateAndSubmit,
        ),
        SizedBox(
          height: 5,
        ),
        RaisedButton(
          color: Colors.red,
          textColor: Colors.white,
          child: Text('Account Exist ? Login',
              style: TextStyle(fontSize: 14, color: Colors.white)),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
