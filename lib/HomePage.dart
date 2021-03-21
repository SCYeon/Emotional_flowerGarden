import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:emotional_flowerpot/HomePage2.dart';
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
              image: DecorationImage(
                  image: AssetImage("assets/background2.png"),
                  fit: BoxFit.cover)),
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
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new LayoutBuilder(
                    builder: (context, constraint) {
                      return AutoSizeText(
                        now3Fo,
                        style: TextStyle(fontSize: 25),
                        //minimum font size
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
    child: Container(
      child: CustomMultiChildLayout(
        delegate: MyDelegate(objectCenter: FractionalOffset(0.5, 1.15)),
        children: [
          LayoutId(
            id: _Slot.circle,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.23,
              child: Image.asset('assets/flowerpot.png'),
            ),
          ),
          LayoutId(
            id: _Slot.image,
            // Use AspectRatio to emulate an image
            child: AspectRatio(
              aspectRatio: 1.25,
              child: dateTimeImage(context),
            ),
          ),
        ],
      ),
    ),
  );
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
                borderRadius: new BorderRadius.circular(20.0)),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
        ),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 2,
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
                borderRadius: new BorderRadius.circular(20.0)),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/write');
            },
          ),
        ),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 2,
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
                borderRadius: new BorderRadius.circular(20.0)),
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

enum _Slot {
  image,
  circle,
}

class MyDelegate extends MultiChildLayoutDelegate {
  final FractionalOffset objectCenter;

  MyDelegate({@required this.objectCenter});

  @override
  void performLayout(Size size) {
    Size imageSize = Size.zero;
    Offset imagePos = Offset.zero;

    if (hasChild(_Slot.image)) {
      imageSize = layoutChild(_Slot.image, BoxConstraints.loose(size));

      // Center the image in the available space
      imagePos = (size - imageSize as Offset) * 0.5;
      positionChild(_Slot.image, imagePos);
    }

    if (hasChild(_Slot.circle)) {
      Size childSize = layoutChild(_Slot.circle, BoxConstraints());
      positionChild(
          _Slot.circle,
          imagePos +
              objectCenter.alongSize(imageSize) -
              childSize.center(Offset.zero));
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => false;
}
