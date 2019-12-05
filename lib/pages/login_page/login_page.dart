import 'package:agro_share/models/userModel.dart';
import 'package:agro_share/pages/home_page/home_page.dart';
import 'package:agro_share/pages/sign_up_page/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _userMail, _userPassword;
  Size deviceSize;
  static final GlobalKey<FormState> formStateKey = new GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> scaffoldStateKey =
      new GlobalKey<ScaffoldState>();

  bool logningIn = false;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return new Scaffold(
      key: scaffoldStateKey,
      //appBar: new AppBar(),
      body: Center(
        //alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(24.00),
          child: _paddingChild(context),
        ),
      ),
    );
  }

  Widget _paddingChild(context) {
    var form = Form(
      //  autovalidate: false,
      key: formStateKey,
      child: ListView(
        shrinkWrap: true,
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Expanded(child: Container(),),
          // ListView(
          //   //padding: EdgeInsets.only(left: 24.0, right: 24.0),
          //   children: <Widget>[
          //SizedBox(height: 100,),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "E-mail",
              contentPadding: EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
              border: OutlineInputBorder(
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(20),
                  //   topRight: Radius.circular(20),
                  // ),
                  ),
            ),
            validator: emailValidator,
            onSaved: (value) {
              _userMail = value;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Şifrə",
              contentPadding: EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
              border: OutlineInputBorder(
                  // borderRadius: BorderRadius.only(
                  //   bottomLeft: Radius.circular(20),
                  //   bottomRight: Radius.circular(20),
                  // ),
                  ),
            ),
            onSaved: (value) {
              _userPassword = value;
            },
          ),
          //   SizedBox(height: 10,),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text(
                  "Şifrəni unutmusan?",
                  style: TextStyle(color: Colors.red[400]),
                ),
                onPressed: () {},
              ),
              FlatButton(
                color: Colors.blueAccent,
                child: Text("Daxil ol"),
                onPressed: () {
                  //formSubmitted(context);
                  //formStateKey.currentState.validate()
                  setState(() {
                    logningIn = true;
                  });

                  if (true) {
                    formStateKey.currentState.save();
                    try {
                      AuthResult authResult;
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _userMail, password: _userPassword)
                          .then((onValue) {
                        authResult = onValue;

                        UserModel user = new UserModel(
                            uid: authResult.user.providerData[0].uid);

                        Firestore.instance
                            .collection("users")
                            .document(user.uid)
                            .get()
                            .then((userDetails) {
                          user.name = userDetails.data["Name"];
                          user.surname = userDetails.data["Surname"];
                          user.profilePictureUrl = userDetails.data["PhotoUrl"];
                          user.city = userDetails.data["City"];
                          user.phoneNumber = userDetails.data["PhoneNumber"];
                          user.rating = userDetails.data["Rating"] ?? "1";

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return new MyHomePage(
                                userModel: user,
                              );
                            }),
                            ModalRoute.withName('/'),
                          );
                        });
                      }, onError: (eror) {
                        setState(() {
                          logningIn = false;
                        });
                        scaffoldStateKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            "Email və ya şifrə yanlışdır!",
                            style: TextStyle(color: Colors.red),
                          ),
                          duration: Duration(seconds: 4),
                        ));
                      });
                      // Firestore firestore = Firestore();

                    } catch (e) {
                      print("=======-> " + e);
                    }
                  }
                },
              ),
            ],
          ),
          // SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Colors.green,
                        Colors.green[200],
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                width: 100.0,
                height: 1.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  "Və ya",
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Colors.green,
                        Colors.green[200],
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                width: 100.00,
                height: 1.00,
              ),
            ],
          ),

          FlatButton(
            child: Text(
              "Qeydiyyatdan keç",
              style: TextStyle(color: Colors.blue[600]),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpPage();
                  },
                ),
              );
            },
          ),
          //   ],
          // ),
        ],
      ),
    );

    // List<Widget> stackWidgets = [form];
    if (logningIn) {
      return Opacity(
        opacity: 0.30,
        child: Container(
          width: deviceSize
              .width, //scaffoldStateKey.currentState.context.size.width,
          height: deviceSize.height,
          color: Colors.white,
          alignment: Alignment.center,
          child: Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return form;
  }

  String emailValidator(input) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (input.isEmpty() || !regex.hasMatch(input)) {
      return 'Enter Valid Email';
    }
    return null;
  }

  Future<void> formSubmitted(context) async {}
}
