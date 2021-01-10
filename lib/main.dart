import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:weather/home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(
      // backgroundColor: Color(0xffFFe2e2),
      //  backgroundColor: Colors.grey[200],
        seconds: 1,
        navigateAfterSeconds: HOME(),
        title:
        Text(
          'Weather',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: 'Times New Roman',

          ),
        ),
        image: Image.asset('assets/rainy2.png'),
        photoSize: 100,

      ),
      );
  }
}