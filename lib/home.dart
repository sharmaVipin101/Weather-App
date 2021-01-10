import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'city.dart';

class HOME extends StatefulWidget {
  @override
  _HOMEState createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  Future<City> details;
  bool loading = false;

   @override
   void initState(){
     super.initState();
     details = callApi("Shimla");
   }
//  DateTime now = DateTime.now();
  String formattedDate = DateFormat('EEE d MMM').format(DateTime.now());

  Future<City> callApi(String place) async
  {
   // print("call made========");
    setState(() {
      loading=true;
    });
      String url = "http://api.openweathermap.org/data/2.5/weather?APPID=d02d71ac4ef87d0d99e7095542d21819&q=$place";
      Response response = await http.get(url);

    setState(() {
      loading=false;
    });
      if(response.statusCode==200)
        {
          return City.fromJson(jsonDecode(response.body));
        }else{
        throw new Exception('Incorrect City Name');
      }


  }

  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
    body:Center(
      child: FutureBuilder<City>(
        future: details,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return SafeArea(
              child: Container(
                color: Colors.white,//(0xffFFe2e2),
                constraints: BoxConstraints.expand(),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.black),
                          ),
                          labelText: 'City Name',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            splashColor: Colors.blue,

                            onPressed: (){
                              setState(() {
                                details = callApi(textController.text);
                              });
                            },
                          )
                        ),
                      ),
                    ),
                    Container(//location
                        decoration: BoxDecoration(
                          color: Colors.transparent,
//                            border: Border.all(
//                                color: Colors.white,
//                                width: 1.0,
//                                style: BorderStyle.solid
//                            ),
                            borderRadius: BorderRadius.circular(10)

                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            RichText(
                              text:TextSpan(
                                  text: "${snapshot.data.place}, ",
                                  style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                    fontSize: 40,
                                    color:Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: snapshot.data.country,
                                      style: TextStyle(
                                        fontFamily: 'Times New Roman',
                                        fontSize: 40,
                                        color: Colors.red,
                                      ),
                                    )
                                  ]

                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(formattedDate,style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',color:Colors.black,),),
                                //Text('Year')
                              ],
                            ),
                          ],
                        )
                    ),

                    Container(//temp
                      decoration: BoxDecoration(
                        color: Colors.white,
//                          border: Border.all(
//                              color: Colors.white,
//                              width: 1.0,
//                              style: BorderStyle.solid
//                          ),
                          borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                        //color: Colors.white, //background color of box
                        BoxShadow(
                          color: Colors.blueGrey,
                          blurRadius: 25.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            15.0, // Move to right 10  horizontally
                            15.0, // Move to bottom 10 Vertically
                          ),
                        )
                        ],

                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: RichText(
                        text:TextSpan(

                            text:"${(double.parse(snapshot.data.currTmp)-273.15).toStringAsFixed(2)}°",
                            style: TextStyle(
                              fontFamily: 'Times New Roman',
                              fontSize: 70,
                              color:Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'C',
                                style: TextStyle(
                                  fontFamily: 'Times New Roman',
                                  fontSize: 45,
                                  color:Colors.black,
                                ),
                              )
                            ]

                        ),
                      ),
                    ),
//                    Text('')
                    Container(//description
                      decoration:BoxDecoration(
                        color: Colors.white,
//                          border: Border.all(
//                              color: Colors.black,
//                              width: 1.0,
//                              style: BorderStyle.solid
//                          ),
                          borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          //color: Colors.white, //background color of box
                          BoxShadow(
                            color: Colors.blueGrey,
                            blurRadius: 25.0, // soften the shadow
                            spreadRadius: 5.0, //extend the shadow
                            offset: Offset(
                              15.0, // Move to right 10  horizontally
                              15.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],

                      ) ,

                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(snapshot.data.desc,
                                style: TextStyle(
                              fontSize: 30,
                                  fontFamily: 'Times New Roman', color:Colors.black,
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Min: ${(double.parse(snapshot.data.max)-273.15).toStringAsFixed(2)}° C ",style: TextStyle( color:Colors.black,fontFamily: 'Times New Roman'),),
                                Text('/ ',style: TextStyle( color:Colors.black,fontFamily: 'Times New Roman'),),
                                Text("Max: ${(double.parse(snapshot.data.min)-273.15).toStringAsFixed(2)}° C",style: TextStyle( color:Colors.black,fontFamily: 'Times New Roman'),),
                              ],
                            )
                          ],
                        )
                    ),
                    Container(

                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                               color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey,
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ]

                              ),
                              child: Text("Lat: ${double.parse(snapshot.data.lat).toStringAsFixed(2)}° N",style: TextStyle( color:Colors.black,fontFamily: 'Times New Roman',fontSize: 20),)),
                          Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey,
                                      blurRadius: 5.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ]

                              ),
                              child: Text("Lon: ${double.parse(snapshot.data.long).toStringAsFixed(2)}° E",style: TextStyle( color:Colors.black,fontFamily: 'Times New Roman',fontSize: 20),)),
                        ],

                      ),
                    ),
//                    Container(
//                        color: Colors.transparent,
//                        margin: EdgeInsets.all(10),
//                        padding: EdgeInsets.all(10),
//                        child: Icon(Icons.wb_sunny)
//                    ),
                    Container(//extra

                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        //color: Colors.transparent,
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 2.0,
                          style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(10)

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.cloud_circle,color: Colors.lightGreenAccent,),
                              Text('${snapshot.data.humi}%',style: TextStyle( color:Colors.black,fontFamily: 'Times New Roman'),),
                              Text('Humidity',style: TextStyle( color:Colors.black,fontFamily: 'Times New Roman'),),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.wrap_text,color: Colors.yellow),
                              Text('${snapshot.data.wind} km/h',style: TextStyle(color:Colors.black,fontFamily: 'Times New Roman'),),
                              Text('Wind',style: TextStyle(color:Colors.black,fontFamily: 'Times New Roman'),),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.grain,color: Colors.redAccent,),
                              Text('${snapshot.data.pres} mb',style: TextStyle(color:Colors.black,fontFamily: 'Times New Roman'),),
                              Text('Pressure',style: TextStyle(color:Colors.black,fontFamily: 'Times New Roman'),),
                            ],
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            );
          }else if(snapshot.hasError)
            {
               return Container(
                 child: RaisedButton(
                   child: Text('Invalid Input'),
                   onPressed: (){
                     Navigator.push(context, new MaterialPageRoute(
                         builder:(context)=>HOME()
                     ));
                   },
                 )
               );
            }else return CircularProgressIndicator();
        },
      ),
    ),

    );
  }
}


