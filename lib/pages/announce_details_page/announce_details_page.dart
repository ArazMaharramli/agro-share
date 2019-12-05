import 'package:agro_share/models/announceModel.dart';
import 'package:agro_share/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class AnnounceDetailsPage extends StatelessWidget {
  final AnnounceModel model;
  final UserModel userModel;
  AnnounceDetailsPage({this.model, this.userModel});
  final GlobalKey<FormState> _suggestFormKey = new GlobalKey<FormState>();
  PriceSuggestionsModel _priceSuggestionsModel = new PriceSuggestionsModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: generateList(context),
        ),
      ),
    );
  }

  List<Widget> list = new List<Widget>();
  generateList(context) {
    list.clear();
    model.priceSuggestions.forEach((item) {
      List<Widget> stars = new List<Widget>();
      for (var i = 0; i < int.parse(item.rating); i++) {
        stars.add(Icon(Icons.star, color: Colors.yellow));
      }
      list.add(ListTile(
          title: Row(
            children: [
              Text(item.fullName, style: TextStyle(fontSize: 16)),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("${item.suggestion} AZN",
                      style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: stars,
          )

          // ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: int.parse(model.priceSuggestions[index].rating),
          //   itemBuilder: (context, i) {
          //     return Container(
          //       child: Icon(Icons.star, color: Colors.yellow),
          //     );
          //   },
          // ),
          ));
    });
    list.insert(
      0,
      Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.4,
        alignment: Alignment.center,
        child: Text(
          model.message,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          softWrap: true,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
    list.add(FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Təklif et",
            style: TextStyle(
                fontSize: 18, fontStyle: FontStyle.italic, color: Colors.green),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.accessibility_new,
              color: Colors.green[400],
            ),
          ),
        ],
      ),
      // Container(
      //   width: MediaQuery.of(context).size.width-32,
      //   height:100,
      //   child: ,
      //   decoration: BoxDecoration(color: Colors.grey[200]),
      // ),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Form(
                key: _suggestFormKey,
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 30, top: 30),
                          child: Text(
                            "Yeni qiymət təklifi edin",
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      minLines: 1,
                      maxLines: 1,
                      maxLength: 5,
                      //   obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Təklifiniz",
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
                        _priceSuggestionsModel.suggestion = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ButtonBar(children: <Widget>[
                        FlatButton(
                          child: Text("Göndər"),
                          onPressed: () {
                            _suggestFormKey.currentState.save();
                            if (_priceSuggestionsModel.suggestion.isEmpty) {
                              alert(context, "Qiymət daxil edin",
                                  Icons.error_outline);
                            } else {
                              _priceSuggestionsModel.fullName =
                                  "${userModel.name} ${userModel.surname}";
                              _priceSuggestionsModel.rating = userModel.rating??"2";
                              model.priceSuggestions
                                  .add(_priceSuggestionsModel);
                              Firestore.instance
                                  .collection("announcements")
                                  .document(model.docId)
                                  .get()
                                  .then((onValue) {
                                if (onValue.exists) {
                                  List<AnnounceModel> _datas =
                                      model.fromStream(onValue);

                                  _datas[model.index]
                                      .priceSuggestions
                                      .add(_priceSuggestionsModel);

                                  List<Map<String, dynamic>> _datasMap =
                                      new List<Map<String, dynamic>>();
                                  _datas.forEach((announce){
                                    _datasMap.add(announce.toMap());
                                  });

                                  Firestore.instance
                                      .collection("announcements")
                                      .document(model.docId)
                                      .updateData({
                                    "announces": _datasMap
                                  }).then((onValue) {
                                    alert(context, "", Icons.check,
                                        iconColor: Colors.green);
                                  }, onError: (error) {
                                    alert(context, "Xəta baş verdi",
                                        Icons.sentiment_very_dissatisfied);
                                    print(error.toString());
                                  });

                                  //     .updateData({
                                  //   "announces":
                                  //       FieldValue.arrayUnion([model.toMap()])
                                  // });

                                  Navigator.of(context).pop();
                                } else {
                                  alert(context, "Xəta baş verdi", Icons.error);
                                }
                              });
                            }
                          },
                        )
                      ]),
                    ),
                  ],
                ),
              );
            });
      },
    ));
    return list;
  }

  alert(context, text, icon, {iconColor}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.red),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: iconColor ?? Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

// ListView.builder(
//                 itemCount: model.priceSuggestions.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     title: Row(
//                       children: [
//                         Text(model.priceSuggestions[index].fullName),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child:
//                                 Text(model.priceSuggestions[index].suggestion),
//                           ),
//                         )
//                       ],
//                     ),
//                     subtitle:
//                     Row(
//                       children: <Widget>[
//                         Text(model.priceSuggestions[index].rating.toString()),
//                         Icon(Icons.star, color: Colors.yellow)
//                       ],
//                     ),

//                     // ListView.builder(
//                     //   scrollDirection: Axis.horizontal,
//                     //   itemCount: int.parse(model.priceSuggestions[index].rating),
//                     //   itemBuilder: (context, i) {
//                     //     return Container(
//                     //       child: Icon(Icons.star, color: Colors.yellow),
//                     //     );
//                     //   },
//                     // ),
//                   );
//                 }),
