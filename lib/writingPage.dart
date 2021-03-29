import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'gardenPage.dart';

class Diary {
  var num;
  DateTime day;
  String diary;
  String emotion;

  Diary(this.num, this.day, this.emotion, this.diary);
}

class WritingPage extends StatefulWidget {
  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  DateTime _selectedTime;
  var _todayEmotion = '';
  var _todayController = TextEditingController();
  final maxLines = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(
            Icons.clear_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // 뒤로가기 버튼
        title: Text(
          "Emotinal Garden",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'IndieFlower',
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add_outlined,
                color: Colors.black,
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int num = (prefs.getInt('num') ?? 0) + 1;
                await prefs.setInt('num', num);

                _addToday(Diary(
                    num, _selectedTime, _todayEmotion, _todayController.text));
              }), // 저장 버튼
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          //buildTop()
          SizedBox(
            height: 20,
          ),
          IconButton(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.black45,
            ),
            onPressed: () {
              Future<DateTime> selectedDate = showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData.dark(),
                    child: child,
                  );
                },
              );
              selectedDate.then((dateTime) {
                setState(() {
                  _selectedTime = dateTime;
                });
              });
            },
          ),
          //buildMiddle()
          Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "How do you feel today?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontFamily: 'Gaegu',
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/happy.png'),
                    iconSize: 50,
                    onPressed: () {
                      _todayEmotion = 'happy';
                    },
                  ),
                  IconButton(
                    icon: Image.asset('assets/good.png'),
                    iconSize: 50,
                    onPressed: () {
                      _todayEmotion = 'good';
                    },
                  ),
                  IconButton(
                    icon: Image.asset('assets/soso.png'),
                    iconSize: 50,
                    onPressed: () {
                      _todayEmotion = 'soso';
                    },
                  ),
                  IconButton(
                    icon: Image.asset('assets/bad.png'),
                    iconSize: 50,
                    onPressed: () {
                      _todayEmotion = 'bad';
                    },
                  ),
                  IconButton(
                    icon: Image.asset('assets/sad.png'),
                    iconSize: 50,
                    onPressed: () {
                      _todayEmotion = 'sad';
                    },
                  ),
                ],
              ),
            ],
          ),
          //buildBottom()
          Container(
            margin: EdgeInsets.all(12),
            height: maxLines * 24.0,
            child: Column(
              children: [
                TextField(
                  style: TextStyle(fontFamily: 'Gaegu'),
                  controller: _todayController,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    hintText: "How did you spend your day?",
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addToday(Diary today) {
    //감정 카운트
    //firesotre에 저장
    Firestore.instance.collection('todayDiary').add({
      'day': today.day,
      'diary': today.diary,
      'emotion': today.emotion,
      'number': today.num,
    });

    //Firestore.instance.collection('flower').document('list')
    //   .updateData({'flower_list':FieldValue.arrayUnion([today.emotion])});
    Firestore.instance.collection("flower").document("count").get()
        .then((DocumentSnapshot ds) {
    int c = 0;
    if (today.emotion == 'happy') {
        c = ds.data["blueCount"];
        int n;
        Firestore.instance.collection("flower").document('list').get()
            .then((DocumentSnapshot ds) {
          n = ds.data['count'];
          String t = "$n";
          n = n + 1;
          Firestore.instance.collection('flower').document('list').updateData({'count': n});
          //n = c + 100;
          //t = "$n";
          Firestore.instance.collection('flower').document('list').updateData({t: 100});
        });
        c = c + 1;
        Firestore.instance.collection('flower').document('count').updateData({'blueCount': c});
    }
    else if (today.emotion == 'good') {
        c = ds.data["greenCount"];

        int n;
        Firestore.instance.collection("flower").document('list').get()
            .then((DocumentSnapshot ds) {
          n = ds.data['count'];
          String t = "$n";
          n = n + 1;
          Firestore.instance.collection('flower').document('list').updateData({'count': n});
          //n = c + 200;
          //t = "$n";
          Firestore.instance.collection('flower').document('list').updateData({t: 200});
        });
        c = c + 1;
        Firestore.instance.collection('flower').document('count').updateData({'greenCount': c});
    }
    else if (today.emotion == 'soso') {
        c = ds.data["purpleCount"];
        int n;
        Firestore.instance.collection("flower").document('list').get()
            .then((DocumentSnapshot ds) {
          n = ds.data['count'];
          String t = "$n";
          n = n + 1;
          Firestore.instance.collection('flower').document('list').updateData({'count': n});
          //n = c + 300;
          //t = "$n";
          Firestore.instance.collection('flower').document('list').updateData({t: 300});
        });
        c = c + 1;
        Firestore.instance.collection('flower').document('count').updateData({'purpleCount': c});
    }
    else if (today.emotion == 'bad') {
        c = ds.data["redCount"];
        int n;
        Firestore.instance.collection("flower").document('list').get()
            .then((DocumentSnapshot ds) {
          n = ds.data['count'];
          String t = "$n";
          n = n + 1;
          Firestore.instance.collection('flower').document('list').updateData({'count': n});
         // n = c + 400;
          //t = "$n";
          Firestore.instance.collection('flower').document('list').updateData({t: 400});
        });
        c = c + 1;
        Firestore.instance.collection('flower').document('count').updateData({'redCount': c});
    }
    else if (today.emotion == 'sad') {
        c = ds.data["yellowCount"];
        int n;
        Firestore.instance.collection("flower").document('list').get()
            .then((DocumentSnapshot ds) {
          n = ds.data['count'];
          String t = "$n";
          n = n + 1;
          Firestore.instance.collection('flower').document('list').updateData({'count': n});
          //n = c + 500;
          //t = "$n";
          Firestore.instance.collection('flower').document('list').updateData({t: 500});
        });
        c = c + 1;
        Firestore.instance.collection('flower').document('count').updateData({'yellowCount': c});
    }}

    );

    var count;

    Firestore fireStore = Firestore.instance;

    flowerColorCount flower = new flowerColorCount();

    fireStore
        .collection("flower")
        .document("count")
        .get()
        .then((DocumentSnapshot ds) {
      flower.purpleCount = ds.data["purpleCount"];
      flower.redCount = ds.data["redCount"];
      flower.greenCount = ds.data["greenCount"];
      flower.yellowCount = ds.data["yellowCount"];
      flower.blueCount = ds.data["blueCount"];

      count = flower.redCount +
          flower.purpleCount +
          flower.greenCount +
          flower.yellowCount +
          flower.blueCount;

      List<int> flowerIndex = List<int>(48);
      //print(count);
      int c = 0;
      /*for (int j = 0; j < flower.redCount; j++) {
        String t = "$c";
        fireStore.collection("flower").document('list')
            .setData({ t: j + 100});
        c++;
      }
      for (int j = 0; j < flower.blueCount; j++) {
        String t = "$c";
        fireStore.collection("flower").document('list')
            .setData({ t : j + 200});
        c++;
      }
      for (int j = 0; j < flower.purpleCount; j++) {
        String t = "$c";
        fireStore.collection("flower").document('list')
            .setData({ t: j + 300});
        c++;
      }
      for (int j = 0; j < flower.yellowCount; j++) {
        String t = "$c";
        fireStore.collection("flower").document('list')
            .setData({ t: j + 400});
        c++;
      }
      for (int j = 0; j < flower.greenCount; j++) {
        String t = "$c";
        fireStore.collection("flower").document('list')
            .setData({ t: j + 500});
        c++;
      }
      for (; c < 48; c++) {
        String t = "$c";
        fireStore.collection("flower").document('list')
            .setData({ t: 0});
      }*/
      /*flowerIndex.shuffle();
      fireStore.collection("flower").document('list').updateData({
        "flower_list":FieldValue.delete() });

      fireStore.collection('flower').document('list').updateData({
        'flower_list': FieldValue.arrayUnion(flowerIndex)
      });*/
    });

    //저장 후 화면 리셋
    _todayController.text = ' ';
    _selectedTime = null;

    //저장되었습니다 띄우는 dialog
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Saved",
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
