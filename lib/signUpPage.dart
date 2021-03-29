import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserInfo{
  var name;
  var email;
  var pw;
  var match_pw;

  UserInfo(this.name, this.email, this.pw, this.match_pw);
}
class SignUpPage extends StatelessWidget {
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
                            "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F3jfzU%2FbtqZoxR9Uew%2FtTGr9rT4vypHlNHG2N3Sy1%2Fimg.gif"),
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
  var _User = TextEditingController();
  var _Email = TextEditingController();
  var _Password = TextEditingController();
  var _PasswordMatch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(23.0),
                      child: Text("Emotional Garden",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'IndieFlower',
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: Colors.black54)),
                    ),
                    SizedBox(height: 50,),
                    TextField(
                      style: TextStyle(fontFamily: 'Gaegu'),
                      controller: _User,
                      decoration: InputDecoration(
                        hintText: "NAME",
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      style: TextStyle(fontFamily: 'Gaegu'),
                      controller: _Email,
                      decoration: InputDecoration(
                        hintText: "EMAIL",
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      obscureText: true,
                      style: TextStyle(fontFamily: 'Gaegu'),
                      controller: _Password,
                      decoration: InputDecoration(
                        hintText: "PASSWORD",
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      obscureText: true,
                      style: TextStyle(fontFamily: 'Gaegu'),
                      controller: _PasswordMatch,
                      decoration: InputDecoration(
                        hintText: "CHECK PASSWORD",
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 30,),
                    new MaterialButton(
                      height: 40.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: new Text("Sign Up"),
                      onPressed: () => {
                        _addUser(UserInfo(_User.text,_Email.text,_Password.text,_PasswordMatch.text)),
                      },
                      splashColor: Colors.blueGrey,
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }

  void _addUser(UserInfo user){
    if(user.pw == user.match_pw){
      //firesotre에 저장
      Firestore.instance.collection('User').add({'Name':user.name, 'Email':user.email, 'Password': user.pw,'Match_password': user.match_pw});

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
                    "Save",
                  ),
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ],
            );
          });
    }
    else{
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
                    "Passwords do not match",
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
}