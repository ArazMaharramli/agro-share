class AnnounceModel {
  String announceName;
  String city;
  String announcerFullName;
  String message;
  List<PriceSuggestionsModel> priceSuggestions=new List<PriceSuggestionsModel>();
  AnnounceModel({this.announceName, this.announcerFullName, this.city,
      this.message, this.priceSuggestions});
}

class PriceSuggestionsModel {
  var fullName;
  var suggestion;
  var rating;

  PriceSuggestionsModel({
    this.fullName,
    this.rating,
    this.suggestion,
  });
  PriceSuggestionsModel.fromJson(Map json){
    if(json.containsKey('FullName')){
      fullName  = json['FullName'];
    }else{
      fullName = "Example";
    }
    if (json.containsKey('Rating')) {
      rating = json['Rating'];
    }
    else{
      rating = "1";
    }

     if (json.containsKey('Suggestion')) {
      suggestion = json['Suggestion'];
    }
    else{
      suggestion = "000";
    }

   // print("+++++++++___________-  ${fullName.runtimeType} ${suggestion.runtimeType} ${rating.runtimeType}");
  }
  
}
