import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:physic/profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF17352E),
        title: Text(
          "Physic",
          style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Amaranth',
            color: Colors.white,
          ),
        ),
       actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () async{
            // do something
            await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                Navigator.pushReplacementNamed(context, '/');
          },
        )
  ],
      ),
      body: Container(
        color: Color(0xFF559584),
        child: Column(
          children: [
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('teams')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot?> snapshot) {
                    
                      if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.active){
                        List<Widget> teams  = snapshot.data!.docs.map((DocumentSnapshot document){
                        
                        return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: Color(0xFF559584),
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            // if you need this
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Container(
                            color: Colors.transparent,
                            width: 180,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage("assets/images/img.png"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document['name'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontFamily: 'JosefinSans',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 70.0,
                                          ),
                                          Text(
                                            'People working: ',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'JosefinSans',
                                              color: Color(0xFFCFFF48),
                                            ),
                                          ),
                                          Text(
                                            document['people'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'JosefinSans',
                                              color: Color(0xFFCFFF48),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                          );
                        }).toList();
                      return new ListView(children: teams);
                    }
            
                    else {
                      print("####################");
                      print(snapshot.connectionState);
                      return Container(
                        color: Color(0xFF559584),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}








//           return Container(
                //             height: 220,
                //             width: 220,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.all(Radius.circular(10)),
                //             ),
                //             //  color: snapshot.data,
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.all(Radius.circular(10)),
                //               child: snapshot.data,
                //             ),
                //           );
                //         }),
                //   StreamBuilder<QuerySnapshot>(
                //     stream: FirebaseFirestore.instance
                //                     .collection('complaints')
                //                     .orderBy('filing time', descending: true)
                //                     .snapshots(),
                //                 builder: (BuildContext context,
                //                     AsyncSnapshot<QuerySnapshot> snapshot) {
                // return Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: Card(
                //             color: Color(0xFF17352E),
                //             elevation: 10.0,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(30),
                //               // if you need this
                //               side: BorderSide(
                //                 color: Colors.transparent,
                //               ),
                //             ),
                //             child: Container(
                //               color: Colors.transparent,
                //               width: 180,
                //               height: 100,
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 crossAxisAlignment:
                //                 CrossAxisAlignment.center,
                //                 children: [
                //                   SizedBox(
                //                     width: 10.0,
                //                   ),
                //                   Container(
                //                     width: 70.0,
                //                     height: 70.0,
                //                     decoration: new BoxDecoration(
                //                       shape: BoxShape.circle,
                //                       image: new DecorationImage(
                //                         fit: BoxFit.fill,
                //                         image: AssetImage("assets/images/img.png"),
                //                       ),
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     width: 20.0,
                //                   ),
                //                   Flexible(
                //                     child: Column(
                //                       mainAxisAlignment:
                //                       MainAxisAlignment.center,
                //                       crossAxisAlignment:
                //                       CrossAxisAlignment.start,
                //                       children: [
                //                         Text(
                //                           'Marketing Team',
                //                           maxLines: 2,
                //                           overflow: TextOverflow.ellipsis,
                //                           style: TextStyle(
                //                             fontSize: 22.0,
                //                             fontFamily: 'JosefinSans',
                //                             fontWeight: FontWeight.w400,
                //                             color: Colors.white,
                //                           ),
                //                         ),
                //                         SizedBox(
                //                           height: 10.0,
                //                         ),
                //                         Row(
                //                           mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                           children: [
                //                             SizedBox(
                //                               width: 70.0,
                //                             ),
                //                             Text(
                //                               "Total People: 15",
                //                               overflow:
                //                               TextOverflow.ellipsis,
                //                               style: TextStyle(
                //                                 fontSize: 15.0,
                //                                 fontFamily: 'JosefinSans',
                //                                 color: Color(0xFFCFFF48),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     width: 10.0,
                //                   ),
                //                 ],
                //               ),
                //             ),

                //         ),
                //       );
                                    
                //                     }
                //   ),
                                    
                //    ListView(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: 
                //   Card(
                //             color: Color(0xFF17352E),
                //             elevation: 10.0,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(30),
                //               // if you need this
                //               side: BorderSide(
                //                 color: Colors.transparent,
                //               ),
                //             ),
                //             child: Container(
                //               color: Colors.transparent,
                //               width: 180,
                //               height: 100,
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 crossAxisAlignment:
                //                 CrossAxisAlignment.center,
                //                 children: [
                //                   SizedBox(
                //                     width: 10.0,
                //                   ),
                //                   Container(
                //                     width: 70.0,
                //                     height: 70.0,
                //                     decoration: new BoxDecoration(
                //                       shape: BoxShape.circle,
                //                       image: new DecorationImage(
                //                         fit: BoxFit.fill,
                //                         image: AssetImage("assets/images/img.png"),
                //                       ),
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     width: 20.0,
                //                   ),
                //                   Flexible(
                //                     child: Column(
                //                       mainAxisAlignment:
                //                       MainAxisAlignment.center,
                //                       crossAxisAlignment:
                //                       CrossAxisAlignment.start,
                //                       children: [
                //                         Text(
                //                           'Marketing Team',
                //                           maxLines: 2,
                //                           overflow: TextOverflow.ellipsis,
                //                           style: TextStyle(
                //                             fontSize: 22.0,
                //                             fontFamily: 'JosefinSans',
                //                             fontWeight: FontWeight.w400,
                //                             color: Colors.white,
                //                           ),
                //                         ),
                //                         SizedBox(
                //                           height: 10.0,
                //                         ),
                //                         Row(
                //                           mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                           children: [
                //                             SizedBox(
                //                               width: 70.0,
                //                             ),
                //                             Text(
                //                               "Total People: 15",
                //                               overflow:
                //                               TextOverflow.ellipsis,
                //                               style: TextStyle(
                //                                 fontSize: 15.0,
                //                                 fontFamily: 'JosefinSans',
                //                                 color: Color(0xFFCFFF48),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     width: 10.0,
                //                   ),
                //                 ],
                //               ),
                //             ),

                //         ),
                //       ),
                     
                     
                //       Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: Card(
                //           color: Color(0xFF17352E),
                //           elevation: 10.0,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30),
                //             // if you need this
                //             side: BorderSide(
                //               color: Colors.transparent,
                //             ),
                //           ),
                //           child: Container(
                //             color: Colors.transparent,
                //             width: 180,
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment:
                //               CrossAxisAlignment.center,
                //               children: [
                //                 SizedBox(
                //                   width: 10.0,
                //                 ),
                //                 Container(
                //                   width: 70.0,
                //                   height: 70.0,
                //                   decoration: new BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     image: new DecorationImage(
                //                       fit: BoxFit.fill,
                //                       image: AssetImage("assets/images/img.png"),
                //                     ),
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   width: 20.0,
                //                 ),
                //                 Flexible(
                //                   child: Column(
                //                     mainAxisAlignment:
                //                     MainAxisAlignment.center,
                //                     crossAxisAlignment:
                //                     CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         'Marketing Team',
                //                         maxLines: 2,
                //                         overflow: TextOverflow.ellipsis,
                //                         style: TextStyle(
                //                           fontSize: 22.0,
                //                           fontFamily: 'JosefinSans',
                //                           fontWeight: FontWeight.w400,
                //                           color: Colors.white,
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         height: 10.0,
                //                       ),
                //                       Row(
                //                         mainAxisAlignment:
                //                         MainAxisAlignment.start,
                //                         children: [
                //                           SizedBox(
                //                             width: 70.0,
                //                           ),
                //                           Text(
                //                             "Total People: 15",
                //                             overflow:
                //                             TextOverflow.ellipsis,
                //                             style: TextStyle(
                //                               fontSize: 15.0,
                //                               fontFamily: 'JosefinSans',
                //                               color: Color(0xFFCFFF48),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   width: 10.0,
                //                 ),
                //               ],
                //             ),
                //           ),

                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: Card(
                //           color: Color(0xFF17352E),
                //           elevation: 10.0,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30),
                //             // if you need this
                //             side: BorderSide(
                //               color: Colors.transparent,
                //             ),
                //           ),
                //           child: Container(
                //             color: Colors.transparent,
                //             width: 180,
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment:
                //               CrossAxisAlignment.center,
                //               children: [
                //                 SizedBox(
                //                   width: 10.0,
                //                 ),
                //                 Container(
                //                   width: 70.0,
                //                   height: 70.0,
                //                   decoration: new BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     image: new DecorationImage(
                //                       fit: BoxFit.fill,
                //                       image: AssetImage("assets/images/img.png"),
                //                     ),
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   width: 20.0,
                //                 ),
                //                 Flexible(
                //                   child: Column(
                //                     mainAxisAlignment:
                //                     MainAxisAlignment.center,
                //                     crossAxisAlignment:
                //                     CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         'Marketing Team',
                //                         maxLines: 2,
                //                         overflow: TextOverflow.ellipsis,
                //                         style: TextStyle(
                //                           fontSize: 22.0,
                //                           fontFamily: 'JosefinSans',
                //                           fontWeight: FontWeight.w400,
                //                           color: Colors.white,
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         height: 10.0,
                //                       ),
                //                       Row(
                //                         mainAxisAlignment:
                //                         MainAxisAlignment.start,
                //                         children: [
                //                           SizedBox(
                //                             width: 70.0,
                //                           ),
                //                           Text(
                //                             "Total People: 15",
                //                             overflow:
                //                             TextOverflow.ellipsis,
                //                             style: TextStyle(
                //                               fontSize: 15.0,
                //                               fontFamily: 'JosefinSans',
                //                               color: Color(0xFFCFFF48),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   width: 10.0,
                //                 ),
                //               ],
                //             ),
                //           ),

                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: Card(
                //           color: Color(0xFF17352E),
                //           elevation: 10.0,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30),
                //             // if you need this
                //             side: BorderSide(
                //               color: Colors.transparent,
                //             ),
                //           ),
                //           child: Container(
                //             color: Colors.transparent,
                //             width: 180,
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment:
                //               CrossAxisAlignment.center,
                //               children: [
                //                 SizedBox(
                //                   width: 10.0,
                //                 ),
                //                 Container(
                //                   width: 70.0,
                //                   height: 70.0,
                //                   decoration: new BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     image: new DecorationImage(
                //                       fit: BoxFit.fill,
                //                       image: AssetImage("assets/images/img.png"),
                //                     ),
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   width: 20.0,
                //                 ),
                //                 Flexible(
                //                   child: Column(
                //                     mainAxisAlignment:
                //                     MainAxisAlignment.center,
                //                     crossAxisAlignment:
                //                     CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         'Marketing Team',
                //                         maxLines: 2,
                //                         overflow: TextOverflow.ellipsis,
                //                         style: TextStyle(
                //                           fontSize: 22.0,
                //                           fontFamily: 'JosefinSans',
                //                           fontWeight: FontWeight.w400,
                //                           color: Colors.white,
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         height: 10.0,
                //                       ),
                //                       Row(
                //                         mainAxisAlignment:
                //                         MainAxisAlignment.start,
                //                         children: [
                //                           SizedBox(
                //                             width: 70.0,
                //                           ),
                //                           Text(
                //                             "Total People: 15",
                //                             overflow:
                //                             TextOverflow.ellipsis,
                //                             style: TextStyle(
                //                               fontSize: 15.0,
                //                               fontFamily: 'JosefinSans',
                //                               color: Color(0xFFCFFF48),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   width: 10.0,
                //                 ),
                //               ],
                //             ),
                //           ),

                //         ),
                //       ),
                //       Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: Card(
                      //     color: Color(0xFF17352E),
                      //     elevation: 10.0,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //       // if you need this
                      //       side: BorderSide(
                      //         color: Colors.transparent,
                      //       ),
                      //     ),
                      //     child: Container(
                      //       color: Colors.transparent,
                      //       width: 180,
                      //       height: 100,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment:
                      //         CrossAxisAlignment.center,
                      //         children: [
                      //           SizedBox(
                      //             width: 10.0,
                      //           ),
                      //           Container(
                      //             width: 70.0,
                      //             height: 70.0,
                      //             decoration: new BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               image: new DecorationImage(
                      //                 fit: BoxFit.fill,
                      //                 image: AssetImage("assets/images/img.png"),
                      //               ),
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 20.0,
                      //           ),
                      //           Flexible(
                      //             child: Column(
                      //               mainAxisAlignment:
                      //               MainAxisAlignment.center,
                      //               crossAxisAlignment:
                      //               CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   'Marketing Team',
                      //                   maxLines: 2,
                      //                   overflow: TextOverflow.ellipsis,
                      //                   style: TextStyle(
                      //                     fontSize: 22.0,
                      //                     fontFamily: 'JosefinSans',
                      //                     fontWeight: FontWeight.w400,
                      //                     color: Colors.white,
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 10.0,
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                   MainAxisAlignment.start,
                      //                   children: [
                      //                     SizedBox(
                      //                       width: 70.0,
                      //                     ),
                      //                     Text(
                      //                       "Total People: 15",
                      //                       overflow:
                      //                       TextOverflow.ellipsis,
                      //                       style: TextStyle(
                      //                         fontSize: 15.0,
                      //                         fontFamily: 'JosefinSans',
                      //                         color: Color(0xFFCFFF48),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 10.0,
                      //           ),
                      //         ],
                      //       ),
                      //     ),

                      //   ),
                      // ),