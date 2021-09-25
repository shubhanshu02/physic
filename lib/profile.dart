import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// var st = FirebaseAuth.instance.currentUser;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return
      // FutureBuilder(
      //   future: FirebaseFirestore.instance.collection('users').doc(st.uid).get(),
      //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
       Scaffold(
         body: Container(
           color: Color(0xFF1D5149),
           child: Column(
             children: [
               SizedBox(height: 90,),
               Text(
                 "Ek achha sa quote",
                 style: TextStyle(
                   fontSize: 25.0,
                   fontFamily: 'Amaranth',
                   color: Color(0xFFCFFF48),
                 ),
               ),
               SizedBox(height: 20),
               Container(
                 child: Container(
                   alignment: Alignment(0.0,2.5),
                   child: CircleAvatar(
                     backgroundImage: AssetImage("assets/images/img.jpg"),
                     radius: 60.0,
                   ),
                 ),
               ),
               SizedBox(height: 20),
               Center(
                 child: Text(
                   'Kenny Patel',
                   // user.data['name'],
                   style: TextStyle(
                     fontFamily: 'Amaranth',
                     fontSize: 22.0,
                       color: Colors.white
                   ),
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
                                     color:  Color(0xFF17352E),
                                     fontFamily: 'Roboto',
                                   )),
                               SizedBox(height: 5.0),
                               Row(
                                 children: [
                                   SizedBox(width: 5.0),
                                   Text('Marketing',
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
                                     color:  Color(0xFF17352E),
                                     fontFamily: 'Roboto',
                                   )),
                               SizedBox(height: 5.0),
                               Row(
                                 children: [
                                   SizedBox(width: 5.0),
                                   Text('20',
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
                                 // editList1(context);
                               },
                               icon: Icon(Icons.edit, color:  Color(0xFF17352E))),
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
                               Text('Weight',
                                   style: TextStyle(
                                     color:  Color(0xFF17352E),
                                     fontFamily: 'Roboto',
                                   )),
                               SizedBox(height: 5.0),
                               Row(
                                 children: [
                                   SizedBox(width: 5.0),
                                   Text('54',
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
                                 // editList1(context);
                               },
                               icon: Icon(Icons.edit, color:  Color(0xFF17352E))),
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
                               Text('Height',
                                   style: TextStyle(
                                     color:  Color(0xFF17352E),
                                     fontFamily: 'Roboto',
                                   )),
                               SizedBox(height: 5.0),
                               Row(
                                 children: [
                                   SizedBox(width: 5.0),
                                   Text('5.4',
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
                                 // editList1(context);
                               },
                               icon: Icon(Icons.edit, color:  Color(0xFF17352E))),
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
      // });
  }
}

