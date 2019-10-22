import 'package:agro_share/pages/my_vehicles_page/add_vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyVehiclesPage extends StatelessWidget {
  final String userUid;
  MyVehiclesPage({this.userUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Material(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection("vehicles")
                  .document(userUid)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || !snapshot.data.exists) {
                  return Center(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    //children: <Widget>[],
                    child: Text("Texnika əlavə etməmisiniz"),
                  );
                } else {
                  return Column(
                    children: List.generate(snapshot.data["vehicles"].length,
                        (index) {
                      var item = snapshot.data["vehicles"][index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        height: 110,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 100,
                                child: ListTile(
                                  title: Text(item["Name"]),
                                  subtitle: Text(item["MainPurpose"]),
                                  leading: Container(
                                    // padding: EdgeInsets.all(10),
                                    width: 100,
                                    height: 100,
                                    child: Image(
                                        image: NetworkImage(item["PhotoUrl"]),
                                        fit: BoxFit.cover),
                                    // decoration: BoxDecoration(
                                    //   image: DecorationImage(
                                    //     image: NetworkImage(item["PhotoUrl"]),
                                    //     fit: BoxFit.cover
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                }

                // GridView.count(
                //   crossAxisCount: 2,
                //   children:

                // );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddVehicle(userUid: userUid))),
      ),
    );
  }
}
