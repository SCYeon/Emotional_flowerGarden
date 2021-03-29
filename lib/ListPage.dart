import 'package:flutter/material.dart';
import 'ListPageBody.dart';
import 'Homepage.dart';

void main() {
  runApp(MyList());
}

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListPageDemo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }
}

// ListPage 클래스
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "You And Gardenflower",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'IndieFlower',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          //상단 오른쪽의 아이콘
          IconButton(
            color: Colors.black,
            iconSize: 30.0,
            icon: Icon(Icons.keyboard_backspace_rounded),
            tooltip: 'Return Main Page',
            onPressed: (){
              //누르면 홈페이지로 이동
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
      body: Container(
          child: ListPageBody(),
      ),
    );
  }
}
