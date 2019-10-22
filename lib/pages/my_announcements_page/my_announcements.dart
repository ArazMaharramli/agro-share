import 'package:agro_share/models/announceModel.dart';
import 'package:agro_share/pages/announce_details_page/announce_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAnnouncementsPage extends StatelessWidget {
  final userUid;
  MyAnnouncementsPage({this.userUid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("announcements")
            .document(userUid)
            .snapshots(),
        builder: (context, snapshot) {
          return ListView(
            children: generateListItems(snapshot.data["announces"], context),
          );
        },
      ),
    );
  }

  generateListItems(data, context) {
    List<Widget> listItems = new List<Widget>();
    // Firestore.instance.collection("announcements").getDocuments().then((docs){
    //  for(var doc in docs.documents){
    //     print(doc.documentID);
    for (var announce in data.reversed) {
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
