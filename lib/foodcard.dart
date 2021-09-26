import 'package:flutter/material.dart';
import 'package:physic/colors.dart';
import 'Update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class foodcard extends StatefulWidget {
  //const foodcard({ Key? key }) : super(key: key);
  final String _name;
  final String _calorie;
  foodcard(this._name,this._calorie);

  @override
  _foodcardState createState() => _foodcardState();
}

class _foodcardState extends State<foodcard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  Color.fromARGB(255, 84, 148, 130),
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0,20.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      child:Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget._name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color3,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                widget._calorie,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color3,
                  fontWeight: FontWeight.bold
                  
                ),
              ),
              FloatingActionButton(
                backgroundColor: color5,
                onPressed: (){
                  
                },
                child: Icon(Icons.add,),
              )
            ],
          ),
        ),
      ),
    );
  }
}


