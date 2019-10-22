import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddVehicle extends StatefulWidget {
  final String userUid;
  AddVehicle({this.userUid});
  @override
  State<StatefulWidget> createState() {
    return _AddVehicleState();
  }
}

class _AddVehicleState extends State<AddVehicle> {
  final List<String> vehiclesDropDownList = [
    "Kombayn",
    "Traktor",
    "Ot Biçən",
    "Pambıq yığan",
    "Toxum Səpən",
    "Ağır mala"
  ];
  final List<String> engineCapacity = [
    "5000 kub sm",
    "7000 kub sm",
    "8000 kub sm",
    "10000 kub sm",
    "12000 kub sm",
    "15000 kub sm",
    "20000 kub sm"
  ];
  Map<String, String> map = {
    "Name": "",
    "EngineCapacity": "",
    "MainPurpose": "",
    "PhotoUrl": ""
  };
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Texnika Əlavə et"),
      ),
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
                      "Agro Share",
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                DropdownButton(
                  value: map["Name"].isEmpty ? null : map["Name"],
                  hint: Text("Texnika Seç"),
                  items: List.generate(vehiclesDropDownList.length, (index) {
                    return DropdownMenuItem<String>(
                      value: vehiclesDropDownList[index],
                      child: Text(vehiclesDropDownList[index]),
                    );
                  }),
                  onChanged: (value) {
                    map["Name"] = value;
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  value: map["EngineCapacity"].isEmpty
                      ? null
                      : map["EngineCapacity"],
                  hint: Text("Mühərrik həcmi"),
                  items: List.generate(engineCapacity.length, (index) {
                    return DropdownMenuItem<String>(
                      value: engineCapacity[index],
                      child: Text(engineCapacity[index]),
                    );
                  }),
                  onChanged: (value) {
                    map["EngineCapacity"] = value;
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Əsas işi",
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
                    map["MainPurpose"] = value;
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
                        formKey.currentState.save();
                        map["PhotoUrl"] =
                            "https://banner2.kisspng.com/20180707/egt/kisspng-tractor-ursus-factory-agricultural-machinery-ursus-5b406565ce0be2.495210851530946917844.jpg";
                        Firestore.instance
                            .collection("vehicles")
                            .document(widget.userUid)
                            .get()
                            .then((onValue) {
                          if (onValue.exists) {
                            Firestore.instance
                                .collection("vehicles")
                                .document(widget.userUid)
                                .updateData({
                              "vehicles": FieldValue.arrayUnion([map])
                            }).then((onValue) {
                              Navigator.pop(context);
                            });
                          }else{
                            Firestore.instance
                                .collection("vehicles")
                                .document(widget.userUid)
                                .setData({
                              "vehicles": FieldValue.arrayUnion([map])
                            }).then((onValue) {
                              Navigator.pop(context);
                            });
                          }
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
