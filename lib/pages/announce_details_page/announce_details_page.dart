import 'package:agro_share/models/announceModel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class AnnounceDetailsPage extends StatelessWidget {
  final AnnounceModel model;
  AnnounceDetailsPage({this.model});

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
    model.priceSuggestions.forEach((item) {
      List<Widget> stars = new List<Widget>();
      for (var i = 0; i < item.rating; i++) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 100,
            color: Colors.grey[350],
          ),
        ],
      ),
      // Container(
      //   width: MediaQuery.of(context).size.width-32,
      //   height:100,
      //   child: ,
      //   decoration: BoxDecoration(color: Colors.grey[200]),
      // ),
      onPressed: () {},
    ));
    return list;
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
