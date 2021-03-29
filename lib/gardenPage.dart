import 'package:emotional_flowerpot/gardenPage2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class flowerColorCount {
  int redCount;
  int blueCount;
  int purpleCount;
  int yellowCount;
  int greenCount;
}

// ignore: camel_case_types
class gardenPage extends StatefulWidget {
  @override
  _gardenPageState createState() => _gardenPageState();
}

// ignore: camel_case_types
class _gardenPageState extends State<gardenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Emotional Flower Garden",
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/garden_back.png"), fit: BoxFit.cover)),

        child: gardenPage2(),
      ),
    );
  }
}