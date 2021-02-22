import 'package:flutter/material.dart';
import 'package:todotrial/pages/drawer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: NavigationDrawer(),
            body: Container(
              child: Text('Login Page'),
            )));
  }
}
