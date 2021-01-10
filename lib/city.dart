class City{
  String place = "";
  String country = "";
  String lat = "";
  String long = "";
  String currTmp = "";
  String desc = "";
  String max = "";
  String min = "";
  String humi = "";
  String wind = "";
  String pres = "";

  City({this.place,this.country,this.currTmp,this.desc,this.humi,this.lat,this.long,this.max,this.min,this.pres,this.wind});

  factory City.fromJson(Map<String,dynamic> json)
  {
    return City(
      place: json['name'],//
      country: json['sys']['country'],//
      lat:json['coord']['lat'].toString(),
      long: json['coord']['lon'].toString(),
      currTmp: json['main']['temp'].toString(),//
      desc: json['weather'][0]['description'],//
      max: json['main']['temp_max'].toString(),//
      min: json['main']['temp_min'].toString(),//
      humi: json['main']['humidity'].toString(),
      wind: json['wind']['speed'].toString(),
      pres: json['main']['pressure'].toString()
    );
  }
}