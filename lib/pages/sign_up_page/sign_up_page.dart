import 'package:agro_share/models/userModel.dart';
import 'package:agro_share/pages/home_page/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  String password = "", mail = "";
  UserModel userModel = new UserModel();
  Map<String, String> map = {
    "Name": "",
    "Surname": "",
    "PhoneNumber": "",
    "City": "",
    "PhotoUrl": ""
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "AgroTaxi",
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Ad",
                    contentPadding:
                        EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(20),
                        //   topRight: Radius.circular(20),
                        // ),
                        ),
                  ),
                  onSaved: (value) {
                    map["Name"] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Soyad",
                    contentPadding:
                        EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(20),
                        //   topRight: Radius.circular(20),
                        // ),
                        ),
                  ),
                  onSaved: (value) {
                    map["Surname"] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Telefon",
                    contentPadding:
                        EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(20),
                        //   topRight: Radius.circular(20),
                        // ),
                        ),
                  ),
                  onSaved: (value) {
                    map["PhoneNumber"] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Rayon",
                    contentPadding:
                        EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(20),
                        //   topRight: Radius.circular(20),
                        // ),
                        ),
                  ),
                  onSaved: (value) {
                    map["City"] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    contentPadding:
                        EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(20),
                        //   topRight: Radius.circular(20),
                        // ),
                        ),
                  ),
                  onSaved: (value) {
                    mail = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Yeni şifrə",
                    contentPadding:
                        EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(20),
                        //   topRight: Radius.circular(20),
                        // ),
                        ),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Yeni şifrə",
                    contentPadding:
                        EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.only(
                        //   bottomLeft: Radius.circular(20),
                        //   bottomRight: Radius.circular(20),
                        // ),
                        ),
                  ),
                  onSaved: (value) {
                    if (value == password) {
                      password = value;
                    }
                  },
                  validator: (value) {
                    if (value != password) {
                      return "Eyni şifəni daxil edin!";
                    } else {
                      return null;
                    }
                  },
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Ləgv et"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("Tamam"),
                      color: Colors.blue,
                      onPressed: () {
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                          duration: Duration(minutes: 1),
                        ));
                        formKey.currentState.validate();
                        formKey.currentState.save();
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: mail, password: password)
                            .then((onValue) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: mail, password: password)
                              .then((user) {
                            userModel.uid = user.user.providerData[0].uid;
                            Firestore.instance
                                .collection("users")
                                .document(userModel.uid)
                                .setData(map)
                                .then((onValue) {
                              Firestore.instance
                                  .collection("users")
                                  .document(userModel.uid)
                                  .get()
                                  .then((userDetails) {
                                userModel.name = userDetails.data["Name"];
                                userModel.surname = userDetails.data["Surname"];
                                userModel.profilePictureUrl =
                                    userDetails.data["PhotoUrl"];
                                userModel.city = userDetails.data["City"];
                                userModel.phoneNumber =
                                    userDetails.data["PhoneNumber"];
                                scaffoldKey.currentState.hideCurrentSnackBar();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return new MyHomePage(
                                      userModel: userModel,
                                    );
                                  }),
                                  ModalRoute.withName('/'),
                                );
                              });
                            });
                          });
                        }, onError: (error) {
                          scaffoldKey.currentState.hideCurrentSnackBar();
                          scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Xəta baş verdi"),
                            duration: Duration(seconds: 5),
                          ));
                          formKey.currentState.reset();
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
