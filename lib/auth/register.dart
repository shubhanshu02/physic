import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';

class TeamData {
  String name = '';
  String id = '';

  TeamData(String name, String id) {
    this.name = name;
    this.id = id;
  }
}

Widget integerFieldHandler(TextEditingController controller, String label) {
  return TextFormField(
    validator: (value) {
      if (value == "") {
        return '$label cannot be left Empty';
      }
      final n = num.tryParse(value ?? "");
      if (n == null) {
        return '"$value" is not a valid $label';
      }
      if (n <= 0) return '$label cannot be less than or equal to zero';
      return null;
    },
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Colors.black)),
      labelText: label,
    ),
  );
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF181D3D),
      child: SafeArea(
        child: Scaffold(body: RegisterForm()),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String gender = "Male";
  String team = "HpV06ZkaazTkzH9VpbJ0";
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _nameController.text = user!.displayName ?? "";
  }

  void formProcessor() async {
    /*
      Add the document of the UserDetails to the usercollection class
    */
    final database = FirebaseFirestore.instance.collection('users');
    await database.doc('${user!.uid}').set({
      'uid': user!.uid,
      'email': user!.email,
      'name': _nameController.text,
      'age': (_ageController.text),
      'weight': (_weightController.text),
      'height': (_heightController.text),
      'gender': gender,
      'teamId': team,
    });
  }

  void _showDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF181D3D)),
          ),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("  Registering...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // Doesn't allow the dialog box to pop
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: alert);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              children: [
                Container(
                    height: 250,
                    width: 250,
                    child: Lottie.asset('assets/lottie/register.json')),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text('Enter Your Details',
                      style: Theme.of(context).textTheme.headline5),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Name cannot be left Empty';
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                integerFieldHandler(_ageController, 'Age'),
                SizedBox(
                  height: 13,
                ),
                integerFieldHandler(_heightController, 'Height'),
                SizedBox(
                  height: 13,
                ),
                integerFieldHandler(_weightController, 'Weight'),
                SizedBox(
                  height: 13,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Container(
                        padding: EdgeInsets.symmetric(horizontal: 11),
                        child: Text(
                          'Gender',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      value: gender,
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                      isExpanded: true,
                      style: Theme.of(context).textTheme.bodyText1,
                      items: <String>[
                        'Male',
                        'Female',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text(
                              value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Container(
                        padding: EdgeInsets.symmetric(horizontal: 11),
                        child: Text(
                          'Team',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      value: team,
                      onChanged: (String? newValue) {
                        setState(() {
                          team = newValue!;
                        });
                      },
                      isExpanded: true,
                      style: Theme.of(context).textTheme.bodyText1,
                      items: <TeamData>[
                        TeamData('Marketing', 'HpV06ZkaazTkzH9VpbJ0'),
                        TeamData('Management', 'KjolKiHaAnikcutmTRMl'),
                        TeamData('Public Relations', 'TpkRIyJEVY689DilgJAE'),
                        TeamData(
                            'Information Technology', 'zw6CNkJWPwqh1rnRnK0A'),
                        TeamData('Maintenance', 'ASvUyihv73zUyKuQ0F8b')
                      ].map<DropdownMenuItem<String>>((TeamData value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text(
                              value.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Establishing Contact with the Server')));
                        _showDialog(context);
                        formProcessor();
                        Navigator.pop(context, '/register');
                        Navigator.pop(context, '/');
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    highlightElevation: 5,
                    color: Color(0xFF181D3D),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..addArc(Rect.fromLTWH(0, 0, size.width / 2, size.width / 3), pi, -1.57)
      ..lineTo(9 * size.width / 10, size.width / 3)
      ..addArc(
          Rect.fromLTWH(
              size.width / 2, size.width / 3, size.width / 2, size.width / 3),
          pi + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 6);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}
