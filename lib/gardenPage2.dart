import 'dart:core';

//mport 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

// ignore: camel_case_types
class gardenPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//본 페이지는 날짜 카운트 확인과 그로인한 꽃의 개화가 확인 불가하여 임의의 값을 넣어 진행함.
    /*final now = new DateTime.now();
    String formatter = DateFormat('y').format(now);
    int nowYFo = int.parse(formatter);
    String formatter2 = DateFormat('M').format(now);
    int nowMFo = int.parse(formatter2);
    String formatter3 = DateFormat('D').format(now);
    int nowDFo = int.parse(formatter3);
*/
// ignore: missing_return
  //날짜로 카운트 했을 시 - 실제 확인이 불가능하여 주석 처리함.
   /*Widget dateTimeImage(BuildContext context) {
     var now2 = new DateTime.now();
     formatter = DateFormat('y').format(now2);
     int now2YFo = int.parse(formatter);
     formatter = DateFormat('M').format(now2);
     int now2MFo = int.parse(formatter);
     formatter = DateFormat('d').format(now2);
     int now2DFo = int.parse(formatter);

     if (now2YFo - nowYFo > 0) {
       now2MFo += 12;
     }
     if (now2MFo - now2MFo > 0) {
       now2DFo += 30;
     }
     //int num = 30;
     //
  if(now2DFo-nowDFo == 30){
    return Image.asset('assets/stem2.png');
  }

   }*/

    //List flowerImage = ['assets/blue_happy.png', 'assets/green_good.png', 'assets/purple_soso.png','assets/red_bad.png', 'assets/yellow_sad.png'];
    List l = [0, 200, 0, 0, 100, 0, 0, 0, 0, 200, 300, 0, 0, 0, 0, 500, 0, 0, 200, 100, 0, 400, 0, 0, 300, 0, 0, 500, 0, 0, 0, 0, 0, 0, 300, 200, 0, 0, 400, 0, 0, 0, 100, 0, 100, 0, 300, 200];

    //Widget flowerImageChange(DocumentSnapshot doc) {
    Widget flowerImageChange(int i) {
      //int i = 1;
      //String t = "$i";
      if (l[i] >= 500)
        return Image.asset('assets/green_good.png');
      else if (l[i] >= 400)
        return Image.asset('assets/yellow_sad.png');
      else if (l[i] >= 300)
        return Image.asset('assets/purple_soso.png');
      else if (l[i] >= 200)
        return Image.asset('assets/blue_happy.png');
      else if (l[i] >= 100) return Image.asset('assets/red_bad.png');
      else return Image.asset('assets/null_image.png');
    }

    return Container(
      /*child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('flower').snapshots(),
          builder: (context, snapshot) {
            final documents = snapshot.data.documents;*/

              child: GridView.count(
                crossAxisCount: 6,
                children:
                    //documents.map((doc) => flowerImageChange(doc)).toList(),
                List.generate(48, (i) {
                  return Center(
                    child: flowerImageChange(i)
                  );
                }),
              ),
            );

  }
}
