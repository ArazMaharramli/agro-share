import 'package:agro_share/models/userModel.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final UserModel user;
  UserProfilePage({this.user}); 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width,
              alignment: AlignmentDirectional.bottomStart,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, left: 10),
                child: Text(
                  "${user.name} ${user.surname}",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.yellow[600],
                image: DecorationImage(image: AssetImage("lib/src/man.png"),fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Telefon",style: TextStyle(color: Colors.black54,)),
                    subtitle: Text("  ${user.phoneNumber}", style: TextStyle(color: Colors.black),),
                  ),
                  ListTile(
                    title: Text("Yer",style: TextStyle(color: Colors.black54,)),
                    subtitle: Text("  ${user.city}", style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
