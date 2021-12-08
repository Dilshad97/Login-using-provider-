import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement/Provider/provider_state.dart';
import 'package:velocity_x/velocity_x.dart';

import 'dashboard.dart';
import 'login.dart';

class ProviderRegistration extends StatefulWidget {
  @override
  _ProviderRegistrationState createState() => _ProviderRegistrationState();
}

class _ProviderRegistrationState extends State<ProviderRegistration> {
  final TextEditingController firstn = TextEditingController();
  final TextEditingController lastn = TextEditingController();
  final TextEditingController emailc = TextEditingController();
  final TextEditingController password = TextEditingController();

  void _signUp(String email, String password, String _image,
      BuildContext context) async {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);
    try {
      if (await _providerState.signUpUser(
          email, password, firstn.text, lastn.text, emailc.text, _image)) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ProviderDashboard()));
      }
    } catch (e) {
      print(e);
    }
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    print('IMAGE??????////$image');
    print('_IMAGE////$_image');
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Registration".text.color(Colors.black).size(20).make(),
                      HeightBox(20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _image.path == null
                                ? 'ulpad imag'
                                : _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xffFDCF09),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: firstn,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.blue[400])),
                            isDense: true,
                            // Added this
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      HeightBox(20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: lastn,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.blue[400])),
                            isDense: true,
                            // Added this
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      HeightBox(20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: emailc,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.blue[400])),
                            isDense: true,
                            // Added this
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      HeightBox(20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Colors.blue[400])),
                            isDense: true,
                            // Added this
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          ),
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      HeightBox(20),
                      GestureDetector(
                          onTap: () async {
                            final close = context.showLoading(msg: "Loading");
                            Future.delayed(4.seconds,
                                close); // Removes toast after 2 seconds
                            // RegisterUser();
                            _signUp(emailc.text, password.text, _image.path,
                                context);
                          },
                          child: "Sign-Up"
                              .text
                              .black
                              .light
                              .xl
                              .makeCentered()
                              .box
                              .black
                              .shadowOutline(outlineColor: Colors.grey)
                              .color(Color(0XFFFF0772))
                              .roundedLg
                              .make()
                              .w(150)
                              .h(40)),
                      HeightBox(140),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProviderLogin()));
          },
          child: RichText(
              text: TextSpan(
            text: 'New User?',
            style: TextStyle(fontSize: 15.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: ' Login Now',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0XFF4321F5)),
              ),
            ],
          )).pLTRB(20, 0, 0, 15),
        ));
  }

// Future<void> addUser() async{
//   // Call the user's CollectionReference to add a new user
//  await users.doc(FirebaseAuth.instance.currentUser.uid)
//       .set({
//         'firstname': firstn.text,
//         'email Add': emailc.text,
//         'lastname': lastn.text
//       }
//       )
//       .then((value) => print("User Added"))
//       .catchError((error) => print("Failed to add user: $error"));
//
// }
}
