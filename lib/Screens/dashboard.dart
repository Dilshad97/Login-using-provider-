import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement/Provider/provider_state.dart';
import 'package:statemanagement/Screens/login.dart';

class ProviderDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    signOut() async {
      if (UserCredential != null) {
        await auth.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ProviderLogin()));
      }
    }

    String documentId = FirebaseAuth.instance.currentUser.uid;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("UID: ${_providerState.getUid}"),
            Text("Email : ${_providerState.getEmail}"),
            FutureBuilder<DocumentSnapshot>(
              future: users.doc(documentId).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (snapshot.hasData && !snapshot.data.exists) {
                  return Text("Data does not exist");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();

                  print('DATA //////$data');

                  return Text(
                      "Full Name: ${data['firstname']} ${data['lastname']}");
                }
                return Text('loading');
              },
            ),
            Column(),
            RaisedButton(
              onPressed: () {
                signOut();
              },
              child: Text("Sign Out "),
            ),
          ],
        ),
      ),
    );
  }
}
