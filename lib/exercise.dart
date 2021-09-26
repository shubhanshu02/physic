import 'package:flutter/material.dart';
import 'package:physic/colors.dart';
import 'Update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class outtake extends StatefulWidget {
  //const outtake({ Key? key }) : super(key: key);
  final String _exercise;
  outtake(this._exercise);

  @override
  _outtakeState createState() => _outtakeState();
}

class _outtakeState extends State<outtake> {
  final _nameController = TextEditingController();

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
                widget._exercise,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color3,
                  fontWeight: FontWeight.bold
                ),
              ),
              /*Text(
                widget._calorie,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color3,
                  fontWeight: FontWeight.bold
                  
                ),
              ),*/
              /*TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username'
                ),
              ),*/
             
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


