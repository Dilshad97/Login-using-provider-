import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement/Provider/provider_state.dart';
import 'package:statemanagement/Screens/dashboard.dart';
import 'package:statemanagement/Screens/registration.dart';
import 'package:velocity_x/velocity_x.dart';

class ProviderLogin extends StatefulWidget {
  @override
  _ProviderLoginState createState() => _ProviderLoginState();
}

class _ProviderLoginState extends State<ProviderLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController resetemailcontroller = TextEditingController();
  TextEditingController newemailcontroller = TextEditingController();
  TextEditingController oldemailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue[400])),
                          isDense: true,
                          // Added this
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        ),
                        cursorColor: Colors.black45,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    HeightBox(20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextField(
                        controller: pass,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.black45),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue[400])),
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
                      onTap: () {
                        _showAlertPasswordDialog();
                      },
                      child: Text(
                        "Forgot Password ? Reset Now",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    HeightBox(20),
                    GestureDetector(
                      onTap: () {
                        _showAlerEmailtDialog();
                      },
                      child: Text(
                        "Forgot Email ? Reset Now",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    HeightBox(10),
                    GestureDetector(
                        onTap: () async {
                          print("Login Clicked Event");
                          _login(email.text, pass.text, context);
                        },
                        child: "Login"
                            .text
                            .white
                            .light
                            .xl
                            .makeCentered()
                            .box
                            .white
                            .shadowOutline(outlineColor: Colors.grey)
                            .color(Color(0XFFFF0772))
                            .roundedLg
                            .make()
                            .w(150)
                            .h(40)),
                    HeightBox(20),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ProviderRegistration()));
          },
          child: RichText(
              text: TextSpan(
            text: 'New User?',
            style: TextStyle(fontSize: 15.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: ' Register Now',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0XFF4321F5)),
              ),
            ],
          )).pLTRB(20, 0, 0, 15),
        ));
  }

  void _login(String email, String password, BuildContext context) async {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);
    try {
      if (await _providerState.loginUser(
        email,
        password,
      )) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ProviderDashboard()));
      }
    } catch (e) {
      print(e);
    }
  }

  void _showAlertPasswordDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset password'),
          content: TextField(
            controller: resetemailcontroller,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                hintText: "Enter your email"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                ProviderState _providerState =
                    Provider.of<ProviderState>(context, listen: false);
                _providerState.resePassword(resetemailcontroller.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showAlerEmailtDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newemailcontroller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: "Enter your new email"),
              ),
              TextField(
                controller: oldemailcontroller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText:"Enter your old email"),
              ),
              TextField(
                controller: pass,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText:  "Enter your password"),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                ProviderState _providerState =
                Provider.of<ProviderState>(context, listen: false);
                _providerState.resetEmailAddress(newemailcontroller.text, oldemailcontroller.text, pass.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // ProviderState _providerState;

  @override
  void initState() {
    super.initState();
    // _providerState = Provider.of<ProviderState>(context, listen: false);
  }
}
