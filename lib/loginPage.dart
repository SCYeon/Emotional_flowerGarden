import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  static const routeName = '/signin';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  _googleSignIn () async {
    final bool isSignedIn = await GoogleSignIn().isSignedIn();
    GoogleSignInAccount googleUser;
    if (isSignedIn) googleUser = await GoogleSignIn().signInSilently();
    else googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    // print("signed in " + user.displayName);
    return user;
  }

  _buildLoading() {
    return Center(child: CircularProgressIndicator(),);
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 100,),
              Text("Emotional\nFlowerpot",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'IndieFlower',
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.black54)),
              SizedBox(height: 50,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'ex) abcd2039@xxx.com',
                  border: OutlineInputBorder(),
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              // Container(height: 10,),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'ex) a1b2c3d4w5',
                  border: OutlineInputBorder(),
                ),
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 10,),
              FlatButton(
                child: Text('Sign in'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                },
              ),
              SizedBox(height: 20,),
              Text("Don't have an account yet?"),
              SignInButton(
                Buttons.Google,
                onPressed: () async {
                  setState(() => _loading = true);
                  await _googleSignIn();
                  setState(() => _loading = false);
                  Navigator.pushReplacementNamed(context, '/first');
                },
              ),
              FlatButton(
                child: Text('Sign up'),
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

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
              _loading ? _buildLoading() : _buildBody(),
            ],
          ),
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:blinking_text/blinking_text.dart';

class loginPage extends StatelessWidget {
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
  var _emailUser = TextEditingController();
  var _passwordUser = TextEditingController();

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
              SizedBox(height: 100,),
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
              new MaterialButton(
                height: 40.0,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: new Text("로그인"),
                onPressed: () => {Navigator.pushNamed(context, '/home')},
                splashColor: Colors.blueGrey,
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signUp');
                },
                child: Text('회원이 아니신가요?',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                    ),
              ),
            ],
          ),
        ),
      ),
    ),
        ]);
  }
}
*/