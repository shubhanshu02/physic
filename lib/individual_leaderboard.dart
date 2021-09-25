import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class IndividualLeaderboard extends StatefulWidget {
  final String id;
  const IndividualLeaderboard(this.id);
  @override
  _IndividualLeaderboardState createState() => _IndividualLeaderboardState();
}

class _IndividualLeaderboardState extends State<IndividualLeaderboard> {
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
            'Leaderboard',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {
                _selectDate(context);
                print(currentDate);
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
                widget.id,
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
                        print(snapshot);
                        return SizedBox(
                            child: new ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            print(document['name']);
                            print(DateTime.parse(DateTime.now().toString()));
                            return new Stack(
                              children: <Widget>[
                                new Container(
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
                                      Padding(
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
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Calories taken: 10',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.8),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Calories Burnt: 10',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.8),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    width: 70,
                                    height: 70,
                                    margin: EdgeInsets.only(
                                        left: 10,
                                        right: 0,
                                        top: 40,
                                        bottom: 20),
                                    child: ClipOval(
                                      child: Material(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text('10',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    letterSpacing: 1.35,
                                                    fontFamily: 'Fjalla_One',
                                                    color: Color.fromRGBO(
                                                        48, 87, 76, 1))),
                                          )),
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
