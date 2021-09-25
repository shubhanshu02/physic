import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'individual_leaderboard.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    print(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(85, 149, 132, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(29, 81, 73, 1),
          title: Text(
            'Achievements',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {
                _selectDate(context);
              },
              icon: Icon(Icons.calendar_today),
              color: Colors.white,
            )
          ],
        ),
        body: SafeArea(
            child: Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Company XYZ',
                style: TextStyle(
                    foreground: Paint()..shader = linearGradient,
                    fontSize: 30,
                    letterSpacing: 1.35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Fjalla_One'),
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('teams')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        );
                      default:
                        return SizedBox(
                            child: new ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            print(document['name']);
                            print(DateTime.parse(DateTime.now().toString()));
                            return new Stack(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IndividualLeaderboard(
                                                    document['id'])));
                                  },
                                  child: new Container(
                                    height: 100.0,
                                    margin: new EdgeInsets.only(
                                        left: 46.0,
                                        right: 20,
                                        bottom: 20,
                                        top: 20),
                                    decoration: new BoxDecoration(
                                      // color: new Color(0xFF333366),
                                      color: Color.fromRGBO(85, 149, 132, 0.8),
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      boxShadow: <BoxShadow>[
                                        new BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          offset: new Offset(0.0, 10.0),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 45),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                document['name'],
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.8),
                                                    fontSize: 20,
                                                    letterSpacing: 1.35,
                                                    fontFamily: 'Fjalla_One'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 30),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Score',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.8),
                                                  ),
                                                ),
                                                Text(
                                                  '10',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 70,
                                    margin: EdgeInsets.only(
                                        left: 10,
                                        right: 0,
                                        top: 40,
                                        bottom: 20),
                                    child: ClipOval(
                                      child: Material(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.5),
                                        child: Image.asset(
                                          "assets/PR.png",
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ))
                              ],
                            );
                          }).toList(),
                        ));
                    }
                  })
            ],
          ),
        )));
  }
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color.fromRGBO(92, 148, 132, 1),
    Color.fromRGBO(48, 87, 76, 1)
  ],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
