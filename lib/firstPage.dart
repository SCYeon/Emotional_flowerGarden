import 'package:flutter/material.dart';
import 'package:blinking_text/blinking_text.dart';

class firstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Center(
        child: Container(
          height: 700,
          width: 450,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: new NetworkImage(
                            "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbXqtN3%2FbtqVnXac77y%2FNJNLshntkG2bUgXPowj3hK%2Fimg.jpg"),
                        fit: BoxFit.fill)),
              ),
              TextPage()
            ],
          ),
        ),
      ),
    );
  }
}

class TextPage extends StatefulWidget {
  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
            Padding(
            padding: const EdgeInsets.all(23.0),
            child: Text("Emotional\nGarden",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'IndieFlower',
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.black54)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Welcome!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.0,
                    backgroundColor: Colors.amberAccent,
                    color: Colors.black45)),
          ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
            child: BlinkText('Press this!',
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
                beginColor: Colors.black38,
                endColor: Colors.white,
                times: 10,
                duration: Duration(seconds: 1)),
          ),
      ],
    ),)
    ,
    )
    ,
    );
  }
}
