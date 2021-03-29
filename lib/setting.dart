import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var alarmChecked = false;
  final _languageList = ['한국어', 'English'];
  var _selectedLanguage = '한국어';

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Text(
            "Emotional Garden",
            style: TextStyle(fontFamily: 'IndieFlower',),
          ),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
              leading: Icon(Icons.account_circle),
              title: Text('User',
                  style: TextStyle(
                    fontFamily: 'Gaegu',
                    fontSize: 20,
                  )),
            ),
            ListTile(
              leading: Icon(Icons.add_alert),
              title: Text('Notification',
                  style: TextStyle(
                    fontFamily: 'Gaegu',
                    fontSize: 20,
                  )),
              trailing: Switch(
                value: alarmChecked,
                onChanged: (value) {
                  setState(() {
                    alarmChecked = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.language_rounded),
              title: Text('Language',
                  style: TextStyle(
                    fontFamily: 'Gaegu',
                    fontSize: 20,
                  )),
              trailing: DropdownButton(
                value: _selectedLanguage,
                items: _languageList.map(
                      (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
            ),
            ListTile(
                leading: Icon(Icons.zoom_in),
                title: Text('Help',
                      style: TextStyle(
                        fontFamily: 'Gaegu',
                        fontSize: 20,
                      )),
                ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/dev');
              },
              leading: Icon(Icons.accessibility_new),
              title: Text('Developers',
                  style: TextStyle(
                    fontFamily: 'Gaegu',
                    fontSize: 20,
                  )),

            ),
          ],
        ),
      ),
    );
  }
}