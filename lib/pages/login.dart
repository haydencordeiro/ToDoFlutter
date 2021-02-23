import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotrial/api/firebase_api.dart';
import 'package:todotrial/pages/drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todotrial/routes/pageRoute.dart';
import 'package:todotrial/utils/shared_pref.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggedIn = false;
  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();
  void _update(bool count) {
    // print("asdf");
    setState(() => _isLoggedIn = count);
  }

  @override
  void initState() {
    super.initState();
    Shared_Pref.GetIsLogged(_update);
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
      FirebaseApi.UserID = _googleSignIn.currentUser.email;
      FirebaseApi.UserName = _googleSignIn.currentUser.displayName;
      FirebaseApi.UserPhotoURL = _googleSignIn.currentUser.photoUrl;
      FirebaseApi.UisLoggedIn = true;

      Shared_Pref.SetUID(
          _googleSignIn.currentUser.email,
          _googleSignIn.currentUser.displayName,
          _googleSignIn.currentUser.photoUrl,
          true);
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
    FirebaseApi.UserID = "";
    Shared_Pref.SetUID("", "", "", false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      backgroundColor: Color(0xffF4F4F5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.subject_sharp,
            color: Color(0xff53A5D5),
            size: 30.0,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
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
                      FirebaseApi.UserPhotoURL,
                      height: 50.0,
                      width: 50.0,
                    ),
                    Text(FirebaseApi.UserName),
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
