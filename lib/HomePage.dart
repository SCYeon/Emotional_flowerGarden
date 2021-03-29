import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

class Date {
  var date;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Emotional Garden",
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Container(child: _homeTop()),
                Expanded(flex: 20, child: _homeMiddle(context)),
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Expanded(flex: 2, child: _homeBottom(context)),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                )
              ],
            ),
          ),
        ));
  }
}

Widget _homeTop() {
  var formatterT = new DateFormat('MM/dd');
  var now3 = new DateTime.now();
  var now3Fo = formatterT.format(now3);

  return Center(
    child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 4,
            // ignore: deprecated_member_use
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new LayoutBuilder(
                    builder: (context, constraint) {
                      return AutoSizeText(
                        now3Fo,
                        style: TextStyle(fontSize: 25),
                        minFontSize: 10,
                        stepGranularity: 10,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0)),
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
          Expanded(flex: 8, child: SizedBox()),
        ]),
  );
}

Widget _homeMiddle(BuildContext context) {
  return Center(
      child: Column(
    children: <Widget>[
      Expanded(flex: 1, child: SizedBox()),
      Expanded(
        flex: 5,
        child: SizedBox(
          height: 430,
          width: 330,
          // ignore: deprecated_member_use
          child: RaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new LayoutBuilder(
                  builder: (context, constraint) {
                    return new Image(
                        image: AssetImage('assets/bird_chat.PNG'),fit: BoxFit.fill
                        );
                  },
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            color: Colors.white,
            onPressed: () async {
              Navigator.pushNamed(context, '/chat');
            },
          ),
        ),
      ),
      Expanded(flex: 1, child: SizedBox()),
      Expanded(
        flex: 1,
        child: SizedBox(
          height: 20,
          width: 150,
          // ignore: deprecated_member_use
          child: RaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new LayoutBuilder(
                  builder: (context, constraint) {
                    return new Text('Go to the Garden');
                  },
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            color: Colors.white,
            onPressed: () async {
              Navigator.pushNamed(context, '/garden');
            },
          ),
        ),
      ),
    ],
  ));
}

Widget _homeBottom(BuildContext context) {
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 2,
          // ignore: deprecated_member_use
          child: RaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new LayoutBuilder(
                  builder: (context, constraint) {
                    return new Icon(
                      Icons.article_rounded,
                      color: Colors.blueGrey,
                      size: constraint.biggest.height,
                    );
                  },
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0)),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
        ),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 2,
          // ignore: deprecated_member_use
          child: RaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new LayoutBuilder(
                  builder: (context, constraint) {
                    return new Icon(
                      Icons.add_circle_outline,
                      color: Colors.blueGrey,
                      size: constraint.biggest.height,
                    );
                  },
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0)),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/write');
            },
          ),
        ),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 2,
          // ignore: deprecated_member_use
          child: RaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new LayoutBuilder(
                  builder: (context, constraint) {
                    return new Icon(
                      Icons.settings_outlined,
                      color: Colors.blueGrey,
                      size: constraint.biggest.height,
                    );
                  },
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0)),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
          ),
        ),
        Expanded(flex: 1, child: SizedBox()),
      ],
    ),
  );
}
