import 'package:flutter/material.dart';

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
  var _emailUser = TextEditingController();
  var _passwordUser = TextEditingController();
  var _passwordMatch = TextEditingController();

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
                      child: Text("Emotional Flowerpot",
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
                        hintText: "이름",
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      style: TextStyle(fontFamily: 'Gaegu'),
                      controller: _emailUser,
                      decoration: InputDecoration(
                        hintText: "아이디",
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      obscureText: true,
                      style: TextStyle(fontFamily: 'Gaegu'),
                      controller: _passwordUser,
                      decoration: InputDecoration(
                        hintText: "비밀번호",
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      obscureText: true,
                      style: TextStyle(fontFamily: 'Gaegu'),
                      controller: _passwordUser,
                      decoration: InputDecoration(
                        hintText: "비밀번호 확인",
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 30,),
                    new MaterialButton(
                      height: 40.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: new Text("가입하기"),
                      onPressed: () => {Navigator.pushNamed(context, '/login')},
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
}
