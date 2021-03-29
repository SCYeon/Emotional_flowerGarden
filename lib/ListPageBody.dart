import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayDiary {
  var num;
  Timestamp day;
  String diary;
  String emotion;

  TodayDiary(this.num, this.day, this.diary, this.emotion);
}

class ListPageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //writingPage에서 선택한 감정에 따라 이미지 return
    Widget _choiceImage(TodayDiary todayDiary, DocumentSnapshot doc) {
      if (todayDiary.emotion == "good") {
        return Image.asset('assets/good.png');
      }
      else if (todayDiary.emotion == "happy") {
        return Image.asset('assets/happy.png');
      }
      else if (todayDiary.emotion == "soso") {
        return Image.asset('assets/soso.png');
      }
      else if (todayDiary.emotion == "sad") {
        return Image.asset('assets/sad.png');
      }
      else
        return Image.asset('assets/bad.png');
    }

    Widget _buildListWidget(DocumentSnapshot doc) {
      final todayDiary = TodayDiary(doc['num'], doc['day'], doc['diary'], doc['emotion']);
      var dateString;

      if(doc['day'] == null) {
        //시간이 저장되지 않았다면 현재 시간 얻어오기
        DateTime currentDate = DateTime.now();
        dateString = DateFormat('yMMMd').format(currentDate);
      }

      else {
        //firestore시간을 String타입으로
        final Timestamp timestamp = doc.data['day'] as Timestamp;
        final DateTime dateTime = timestamp.toDate();
        dateString = DateFormat('yMMMd').format(dateTime);
      }

      //카드 위젯을 이용하여 작성한 일기 리스트가 나뉘도록 함
      return Container (
        child: Card(
          color: Colors.white60,
          margin: EdgeInsets.only(
              left: 30.0, right: 30.0, bottom: 10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
          child : ListTile(
            //카드별로 순서지정(왼쪽부터 오른쪽으로) 1.이미지
            contentPadding: EdgeInsets.all(0),
            leading:  _choiceImage(todayDiary, doc),
            //2.텍스트(일기)
            title: Text(
              todayDiary.diary,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontFamily: 'Gaegu',
              ),
              textAlign: TextAlign.start,
            ),
            //3.날짜(title 아래에 작게 나옴)
            subtitle: Text(
              dateString,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Gaegu',
              ),
            ),
            //4.마지막 삭제 아이콘
            trailing: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () async {
                Firestore.instance.collection('todayDiary')
                    .document(doc.documentID)
                    .delete();

                Firestore.instance.collection("flower").document("delCount").get()
                .then((DocumentSnapshot ds) {
                  int c = 0;
                  if (todayDiary.emotion == 'happy') {
                    c = ds.data["blueCount"];
                    int n;
                    n = c + 100;
                    String t = "$n";
                    Firestore.instance.collection('flower').document('list').updateData({t: 0});
                      c = c + 1;
                      Firestore.instance.collection('flower')
                          .document('delCount')
                          .updateData({'blueCount': c});
                    }
                  else if (todayDiary.emotion == 'good') {
                    c = ds.data["greenCount"];
                    int n;
                    n = c + 200;
                    String t = "$n";
                    Firestore.instance.collection('flower').document('list').updateData({t: 0});
                    c = c + 1;
                    Firestore.instance.collection('flower')
                        .document('delCount')
                        .updateData({'greenCount': c});
                  }
                  else if (todayDiary.emotion == 'soso') {
                    c = ds.data["purpleCount"];
                    int n;
                    n = c + 300;
                    String t = "$n";
                    Firestore.instance.collection('flower').document('list').updateData({t: 0});
                    c = c + 1;
                    Firestore.instance.collection('flower')
                        .document('delCount')
                        .updateData({'purpleCount': c});
                  }
                  else if (todayDiary.emotion == 'bad') {
                    c = ds.data["redCount"];
                    int n;
                    n = c + 400;
                    String t = "$n";
                    Firestore.instance.collection('flower').document('list').updateData({t: 0});
                    c = c + 1;
                    Firestore.instance.collection('flower')
                        .document('delCount')
                        .updateData({'redCount': c});
                  }
                  else if (todayDiary.emotion == 'sad') {
                    c = ds.data["yellowCount"];
                    int n;
                    n = c + 500;
                    String t = "$n";
                    Firestore.instance.collection('flower').document('list').updateData({t: 0});
                    c = c + 1;
                    Firestore.instance.collection('flower')
                        .document('delCount')
                        .updateData({'yellowCount': c});
                  }
                });
              },
            ),
          ),
        ),
      );
    }


    //배경색을 삽입하기 위해 Scaffold 사용
    return Scaffold (
      backgroundColor: Colors.blueGrey[200],
      //Firestore 연동: 스트림 값이 변경될 때마다 builder부분 다시 호출
      body: StreamBuilder<QuerySnapshot>(
        //날짜 순으로 정렬
          stream: Firestore.instance.collection("todayDiary")
              .orderBy('number', descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final documents = snapshot.data.documents;
            //리스트 형식
            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 20.0),
              children: documents.map((doc) =>
                  _buildListWidget(doc)).toList(),
            );
          }),
    );
  }
}