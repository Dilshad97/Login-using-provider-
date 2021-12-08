import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

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
    notifyListeners();

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

        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        await users
            .doc(getUid)
            .set({
              'firstname': firstn,
              'email Add': emailc,
              'lastname': lastn,
              'img': _image
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    notifyListeners();
  }

  File _image;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<File> imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    print('IMAGE??????////$image');
    print('_IMAGE////$_image');
    _image = image;

    notifyListeners();
    // final String fileName = _image.path.split("/").last;
    File imageFile = File(_image.path);

    try {
      var timekey = DateTime.now();
      var post = await storage
          .ref(getUid)
          .child(timekey.toString())
          .putFile(imageFile);
      print('POST//////$post');
      return image;
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future<File> imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    _image = image;

    try {
      var timekey = DateTime.now();
      var gallery =
          await storage.ref(getUid).child(timekey.toString()).putFile(image);

      print('Galeery images ///////$gallery');

      return image;
    } on FirebaseException catch (error) {
      print(error);
    }

    notifyListeners();
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        _email = userCredential.user.email;
        _name = userCredential.user.displayName;
        notifyListeners();
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
