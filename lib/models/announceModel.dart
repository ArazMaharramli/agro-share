class AnnounceModel {
  String announceName;
  String city;
  String announcerFullName;
  String message;
  String announcerPhone;
  List<PriceSuggestionsModel> priceSuggestions =
      new List<PriceSuggestionsModel>();

  String docId;
  int index;
  AnnounceModel({
    this.announceName,
    this.announcerFullName,
    this.city,
    this.message,
    this.priceSuggestions,
    this.announcerPhone,
    this.docId,
    this.index,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "announceName": announceName,
      "AnnouncerFullName": announcerFullName,
      "AnnouncerPhone": announcerPhone,
      "Message": message,
      "City": city,
      "PriceSuggestions": priceSuggestions.length == 0
          ? []
          : List.generate(priceSuggestions.length,
              (index) => priceSuggestions[index].toMap())
    };
    return map;
  }

  List<AnnounceModel> fromStream(doc) {
    List<AnnounceModel> announceItems = new List<AnnounceModel>();
    int index = 0;
    for (var announce in doc.data["announces"]) {
      index++;
      List<PriceSuggestionsModel> priceSuggestions =
          new List<PriceSuggestionsModel>();
      try {
        for (var item in announce["PriceSuggestions"]) {
          priceSuggestions.add(PriceSuggestionsModel.fromJson(item));
        }
      } catch (e) {
        print("++++++++++++++++++++++++ " + e.toString());
        throw e;
      }

      AnnounceModel model = new AnnounceModel(
          docId: doc.documentID,
          index: index,
          announceName: announce["announceName"],
          announcerFullName: announce["AnnouncerFullName"],
          city: announce["City"],
          message: announce["Message"],
          priceSuggestions: priceSuggestions);
      announceItems.add(model);
    }
    return announceItems;
  }
}

class PriceSuggestionsModel {
  String fullName;
  String suggestion;
  String rating;

  PriceSuggestionsModel({
    this.fullName,
    this.rating,
    this.suggestion,
  });
  PriceSuggestionsModel.fromJson(Map json) {
    if (json.containsKey('FullName')) {
      fullName = json['FullName'].toString();
    } else {
      fullName = "Example";
    }
    if (json.containsKey('Rating')) {
      rating = json['Rating'].toString();
    } else {
      rating = "1";
    }

    if (json.containsKey('Suggestion')) {
      suggestion = json['Suggestion'];
    } else {
      suggestion = "000";
    }

    // print("+++++++++___________-  ${fullName.runtimeType} ${suggestion.runtimeType} ${rating.runtimeType}");
  }

  Map<String, dynamic> toMap() {
    return {"FullName": fullName, "Rating": rating??"2", "Suggestion": suggestion};
  }
}
