import 'package:flutter/material.dart';
import 'package:todotrial/api/firebase_api.dart';
import 'package:todotrial/pages/drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todotrial/routes/pageRoute.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
      FirebaseApi.UserID = _googleSignIn.currentUser.email;
      // print(FirebaseApi.UserID);
      Navigator.pushReplacementNamed(context, pageRoutes.home);
    } catch (err) {
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: NavigationDrawer(),
      backgroundColor: Color(0xffF4F4F5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.subject_sharp,
            color: Color(0xff53A5D5),
            size: 30.0,
          ),
          onPressed: () {},
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "All Task",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
          child: _isLoggedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      _googleSignIn.currentUser.photoUrl,
                      height: 50.0,
                      width: 50.0,
                    ),
                    Text(_googleSignIn.currentUser.displayName),
                    OutlineButton(
                      child: Text("Logout"),
                      onPressed: () {
                        _logout();
                      },
                    )
                  ],
                )
              : Center(
                  child: OutlineButton(
                    child: Text("Login with Google"),
                    onPressed: () {
                      _login();
                    },
                  ),
                )),
    );
  }
}
