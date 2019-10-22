class AnnounceModel {
  String announceName;
  String city;
  String announcerFullName;
  String message;
  String announcerPhone;
  List<PriceSuggestionsModel> priceSuggestions=new List<PriceSuggestionsModel>();
  AnnounceModel({this.announceName, this.announcerFullName, this.city,
      this.message, this.priceSuggestions,this.announcerPhone});
  Map<String,dynamic> toMap(){
    final Map<String,dynamic> map = {
      "announceName":announceName,
      "AnnouncerFullName":announcerFullName,
      "AnnouncerPhone": announcerPhone,
      "Message":message,
      "City":city,
      "PriceSuggestions":priceSuggestions.length==0?[]: List.generate(priceSuggestions.length, (index)=>priceSuggestions[index].toMap())
    };
    return map;
  }
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
  
  Map<String,dynamic> toMap(){
    return {
      "FullName":fullName,
      "Rating":rating,
      "Suggestion":suggestion
    };
  }
}
