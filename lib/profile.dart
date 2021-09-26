import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// final st = FirebaseAuth.instance.currentUser;
// final userid = st.uid;
var uid;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    uid = user?.uid;
  }

  Future<void> editAge(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(
                children: [
                  Text('Edit Age'),
                ],
              ),
              content: TextField(
                controller: customController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Age',
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .update({'age': customController.text});
                    });

                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Save'),
                )
              ]);
        });
  }

  Future<void> editWeight(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(
                children: [
                  Text('Edit Weight'),
                ],
              ),
              content: TextField(
                controller: customController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Weight',
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .update({'weight': customController.text});
                    });

                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Save'),
                )
              ]);
        });
  }

  Future<void> editHeight(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(
                children: [
                  Text('Edit Height'),
                ],
              ),
              content: TextField(
                controller: customController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Height',
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .update({'height': customController.text});
                    });

                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Save'),
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    Map<String, String> teamData = {
      'HpV06ZkaazTkzH9VpbJ0': 'Marketing',
      'KjolKiHaAnikcutmTRMl': 'Management',
      'TpkRIyJEVY689DilgJAE': 'Public Relations',
      'zw6CNkJWPwqh1rnRnK0A': 'Information Technology',
       'ASvUyihv73zUyKuQ0F8b': 'Maintenance',
    };
    String teamName = "";

    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot?> user) {
          print(uid);
          print(user.data?['weight']);
          teamName = teamData[user.data?['teamId']].toString();
          if (user.connectionState == ConnectionState.done && user.hasData)
            // String ? height = user.data?['height'];
            return Scaffold(
              body: Container(
                color: Color(0xFF559584),
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Text(
                      "Your body is a reflection of your lifestyle!",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Amaranth',
                        color: Color(0xFFCFFF48),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Container(
                        alignment: Alignment(0.0, 2.5),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/img.png"),
                          radius: 60.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        // 'Kenny Patel',
                        user.data?['name'],
                        style: TextStyle(
                            fontFamily: 'Amaranth',
                            fontSize: 22.0,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: query.size.width / 14,
                              vertical: query.size.height / 80),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Team',
                                        style: TextStyle(
                                          color: Color(0xFF17352E),
                                          fontFamily: 'Roboto',
                                        )),
                                    SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        SizedBox(width: 5.0),
                                        Text(teamName,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Roboto',
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: query.size.width / 14,
                              vertical: query.size.height / 80),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Age',
                                        style: TextStyle(
                                          color: Color(0xFF17352E),
                                          fontFamily: 'Roboto',
                                        )),
                                    SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        SizedBox(width: 5.0),
                                        Text(user.data?['age'],
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Roboto',
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      editAge(context);
                                    },
                                    icon: Icon(Icons.edit,
                                        color: Color(0xFF17352E))),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: query.size.width / 14,
                              vertical: query.size.height / 80),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Weight (in Kg)',
                                        style: TextStyle(
                                          color: Color(0xFF17352E),
                                          fontFamily: 'Roboto',
                                        )),
                                    SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        SizedBox(width: 5.0),
                                        Text(
                                            //  '43',
                                            user.data?['weight'],
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Roboto',
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      editWeight(context);
                                    },
                                    icon: Icon(Icons.edit,
                                        color: Color(0xFF17352E))),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: query.size.width / 14,
                              vertical: query.size.height / 80),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Height (in cms)',
                                        style: TextStyle(
                                          color: Color(0xFF17352E),
                                          fontFamily: 'Roboto',
                                        )),
                                    SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        SizedBox(width: 5.0),
                                        Text(user.data?['height'],
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Roboto',
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      editHeight(context);
                                    },
                                    icon: Icon(Icons.edit,
                                        color: Color(0xFF17352E))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          else
            return Container(
              color: Color(0xFF559584),
            );
        });
  }
}
