import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todotrial/pages/home.dart';
import 'package:todotrial/pages/login.dart';
import 'package:todotrial/routes/pageRoute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      routes: {
        pageRoutes.home: (context) => Home(),
        pageRoutes.login: (context) => LoginScreen(),
        //  pageRoutes.event: (context) => eventPage(),
        //  pageRoutes.profile: (context) => profilePage(),
        //  pageRoutes.notification: (context) => notificationPage(),
      },
    );
  }
}
