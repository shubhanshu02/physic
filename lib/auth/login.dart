import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:lottie/lottie.dart';
import '../colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginChange = false;
  bool registerChange = false;
  bool loginStateChange() {
    setState(() {
      loginChange = !loginChange;
    });
    return loginChange;
  }

  bool registerStateChange() {
    setState(() {
      registerChange = !registerChange;
    });
    return registerChange;
  }

  Future<void> _handleButtonClick() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Internet Connection'),
            content: SingleChildScrollView(
              child: Text(
                  "You need to have an active internet connection to access this. Please try again later."),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // Start Authentication Process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the requesty
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential _currentUser =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (_currentUser.additionalUserInfo!.isNewUser) {
      // The user is just created
      Navigator.pushNamed(context, '/register');
    } else {
      // The user is already there, so redirect to feed
      Navigator.pop(context);
      Navigator.pushNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment(0.0, 0.0),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          ListView(children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                Container(
                    height: 300,
                    width: 300,
                    child: Lottie.asset('assets/lottie/login.json')),
                Text('Physic', style: Theme.of(context).textTheme.headline3),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(48.0, 12.0, 48.0, 9.0),
                    elevation: 20.0,
                    shape: loginChange
                        ? RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 3.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)))
                        : RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.transparent, width: 3.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0))),
                    color: loginChange ? Colors.transparent : Color(0xFF559584),
                    onPressed: () {
                      loginStateChange();
                      _handleButtonClick();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: loginChange ? Colors.white : Color(0xFF181D3D),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34.0, 12.0, 34.0, 9.0),
                  elevation: 20.0,
                  shape: registerChange
                      ? RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 3.0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)))
                      : RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                  color:
                      registerChange ? Colors.transparent : Color(0xFF559584),
                  onPressed: () {
                    registerStateChange();
                    _handleButtonClick();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'JosefinSans',
                        fontSize: 18.0,
                        color:
                            registerChange ? Colors.white : Color(0xFF181D3D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
//.only(topLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)) -- differently shaped button
