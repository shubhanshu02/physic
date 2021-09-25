import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physic/auth/login.dart';
import 'package:physic/auth/register.dart';

class Physic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(title: 'Physic', routes: {
      '/': (context) => LoginPage(),
      // '/': (context) => (FirebaseAuth.instance.currentUser == null) ? LoginPage() : User1(),
      '/register': (context) => RegisterPage(),
    });
  }
}
