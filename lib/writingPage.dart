import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Diary{
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
        leading:
        IconButton(
          icon: Icon(
            Icons.clear_outlined,
            color:Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),// 뒤로가기 버튼
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
                color:Colors.black,
              ),
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int num = (prefs.getInt('num')?? 0) +1;
                await prefs.setInt('num', num);

                _addToday(Diary(num, _selectedTime, _todayEmotion,_todayController.text));
              }
          ),// 저장 버튼
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          //buildTop()
          SizedBox(height: 20,),
          IconButton(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.black45,
            ),
            onPressed: (){
              Future<DateTime> selectedDate = showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                builder: (BuildContext context, Widget child){
                  return Theme(
                    data: ThemeData.dark(),
                    child: child,
                  );
                },
              );
              selectedDate.then((dateTime){
                setState(() {
                  _selectedTime = dateTime;
                });
              });
            },
          ),
          //buildMiddle()
          Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Text(
                "오늘의 감정은 어떠신가요?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontFamily: 'Gaegu',),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/happy.png'),
                    iconSize: 50,
                    onPressed: () { _todayEmotion = 'happy';},
                  ),
                  IconButton(
                    icon: Image.asset('assets/good.png'),
                    iconSize: 50,
                    onPressed: () { _todayEmotion = 'good';},
                  ),
                  IconButton(
                    icon: Image.asset('assets/soso.png'),
                    iconSize: 50,
                    onPressed: () { _todayEmotion = 'soso';},
                  ),
                  IconButton(
                    icon: Image.asset('assets/bad.png'),
                    iconSize: 50,
                    onPressed: () { _todayEmotion = 'bad';},
                  ),
                  IconButton(
                    icon: Image.asset('assets/sad.png'),
                    iconSize: 50,
                    onPressed: () { _todayEmotion = 'sad';},
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
                    hintText: "어떤 하루를 보냈나요?",
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

  void _addToday(Diary today){
    //감정 카운트
    //firesotre에 저장
    Firestore.instance.collection('todayDiary').add({'number':today.num, 'day':today.day, 'emotion': today.emotion, 'diary': today.diary});
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
                  "저장되었습니다.",
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}