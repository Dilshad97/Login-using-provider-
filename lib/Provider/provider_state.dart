import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProviderState extends ChangeNotifier {
  String _uid;
  String _email;
  String _name;

  String get getUid => _uid;

  String get getEmail => _email;

  String get getName => _name;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(
    String email,
    String password,
    String firstn,
    String lastn,
    String emailc,
    String _image,
  ) async {
    bool retval = false;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        _email = userCredential.user.email;
        _name = userCredential.user.displayName;

        CollectionReference users = FirebaseFirestore.instance.collection('users');

        await users
            .doc(FirebaseAuth.instance.currentUser.uid)
            .set({'firstname': firstn, 'email Add': emailc, 'lastname': lastn, 'img':_image})
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));

        return retval = true;
      }
    } catch (e) {
      print(e);
    }

    return retval;

  }

  Future<bool> loginUser(String email, String password) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        _email = userCredential.user.email;
        _name = userCredential.user.displayName;
        return retval = true;
      }
    } catch (e) {
      print(e);
    }

    return retval;
  }
}
