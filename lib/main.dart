import 'package:agro_share/models/announceModel.dart';
import 'package:agro_share/models/userModel.dart';
import 'package:agro_share/pages/announce_details_page/announce_details_page.dart';
import 'package:agro_share/pages/login_page/login_page.dart';
import 'package:agro_share/pages/my_announcements_page/my_announcements.dart';
import 'package:agro_share/pages/user_profile_page/user_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agro_share/pages/my_vehicles_page/my_vehicles_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  UserModel user = new UserModel();
  MyHomePage({
    Key key,
    userModel,
  }) : super(key: key) {
    if (userModel == null) {
      user = new UserModel(uid: "DEMO UID NULL", name: "", surname: "");
    }
    user = userModel;
  }

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // generateListItems();
  }

  static final GlobalKey<FormState> modalBottomSheetFormKey =
      new GlobalKey<FormState>();
  AnnounceModel announceModel = new AnnounceModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AgroShare"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      shape: BoxShape.circle,
                      color: Colors.green.shade200,
                      image: DecorationImage(
                        image: AssetImage("lib/src/man.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.user.name} ${widget.user.surname}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.perm_identity),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Profilim",
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UserProfilePage(user: widget.user);
                }));
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.directions_car),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Texnikalarım",
                  ),
                ],
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyVehiclesPage(userUid: widget.user.uid))),
            ),
             ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.message),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Elanlarım",
                  ),
                ],
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyAnnouncementsPage(userUid: widget.user.uid))),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.history),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Gördüyüm işlər",
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.settings),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Tənzimləmələr",
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.notifications_active),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Bildirişlər",
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.input),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Çıxış",
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.help_outline),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Kömək və təklif",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("announcements").snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return Column(
                children: generateListItems(snapshot.data.documents[index]),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              // useRootNavigator: true,
              builder: (context) {
                return Container(
                    padding: EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.height - 50,
                    child: Form(
                      key: modalBottomSheetFormKey,
                      child: ListView(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 30, top: 30),
                                child: Text(
                                  "Yeni Elan",
                                  style: TextStyle(fontSize: 26),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 20),
                            // obscureText: true,
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            decoration: InputDecoration(
                              hintText: "Elan adı",
                              contentPadding: EdgeInsets.fromLTRB(
                                  20.00, 10.00, 20.00, 10.00),
                              border: OutlineInputBorder(
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: Radius.circular(20),
                                  //   topRight: Radius.circular(20),
                                  // ),
                                  ),
                            ),
                            onSaved: (value) {
                              announceModel.announceName = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 20),
                            minLines: 5,
                            maxLines: 5,
                            maxLength: 50,
                            //   obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Mesajınız",
                              contentPadding: EdgeInsets.fromLTRB(
                                  20.00, 10.00, 20.00, 10.00),
                              border: OutlineInputBorder(
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: Radius.circular(20),
                                  //   topRight: Radius.circular(20),
                                  // ),
                                  ),
                            ),
                            onSaved: (value) {
                              announceModel.message = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                color: Colors.blue,
                                child: Text(
                                  "Paylaş",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  // setState(() {
                                  //   modalBottomSheetSubmitted = true;
                                  // });
                                  modalBottomSheetFormKey.currentState.save();
                                  Navigator.pop(context);
                                  announceModel.announcerFullName =
                                      "${widget.user.name} ${widget.user.surname}";
                                  announceModel.announcerPhone =
                                      widget.user.phoneNumber;
                                  announceModel.city = widget.user.city;
                                  announceModel.priceSuggestions = [];
                                  Firestore.instance
                                      .collection("announcements")
                                      .document(widget.user.uid)
                                      .get()
                                      .then((onValue) {
                                    if (onValue.exists) {
                                      Firestore.instance
                                          .collection("announcements")
                                          .document(widget.user.uid)
                                          .updateData({
                                        "announces": FieldValue.arrayUnion(
                                            [announceModel.toMap()])
                                      });
                                    } else {
                                      Firestore.instance
                                          .collection("announcements")
                                          .document(widget.user.uid)
                                          .setData({
                                        "announces": FieldValue.arrayUnion(
                                            [announceModel.toMap()])
                                      });
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ));
              });
        },
      ),
      // ListView(
      //   children: generateListItems(),
      // ),
    );
  }

  generateListItems(doc) {
    List<Widget> listItems = new List<Widget>();
    // Firestore.instance.collection("announcements").getDocuments().then((docs){
    //  for(var doc in docs.documents){
    //     print(doc.documentID);
    for (var announce in doc.data["announces"].reversed) {
      List<PriceSuggestionsModel> priceSuggestions =
          new List<PriceSuggestionsModel>();
      //  print("==============="+announce.toString());
      //  print("========== "+announce["PriceSuggestions"].toString());
      try {
        for (var item in announce["PriceSuggestions"]) {
          priceSuggestions.add(PriceSuggestionsModel.fromJson(item)
              // (
              //     fullName: item["FullName"]==null?"asdfghgfdghfg":item["FullName"],
              //     rating: int.parse(item["Rating"]),
              //     suggestion: item["Suggestion"])
              );
        }
      } catch (e) {
        print("++++++++++++++++++++++++ " + e.toString());
        throw e;
      }

      AnnounceModel model = new AnnounceModel(
          announceName: announce["announceName"],
          announcerFullName: announce["AnnouncerFullName"],
          city: announce["City"],
          message: announce["Message"],
          priceSuggestions: priceSuggestions);

      listItems.add(
        new ListTile(
          title: Row(children: [
            Text(model.announceName),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(model.city),
              ),
            )
          ]),
          subtitle: Text(model.announcerFullName),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AnnounceDetailsPage(model: model);
            }),
          ),
        ),
      );
    }
    // }
    // });
    return listItems.length == 0
        ? [
            Container(
              child: Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            )
          ]
        : listItems;
  }
}
