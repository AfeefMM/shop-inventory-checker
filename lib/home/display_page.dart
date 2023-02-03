import 'package:flutter/material.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';
import 'package:inventory_mgmt/widgets/btn_text.dart';

import '../widgets/question_text.dart';
import '../widgets/scanbtn.dart';
import '../widgets/searchBtn.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/Giordano-logo 1.png',
              fit: BoxFit.fill,
              height: 80,
            ),
          ],
        ),
        backgroundColor: AppColours.mainColor,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('Two-line ListTile'),
              subtitle: Text('Here is a second line'),
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 72.0),
              title: QuestionText(
                text: 'Here is a second line',
                size: 18,
              ),
              subtitle: QuestionText(
                text: 'Here is a second line and the line continues to below',
                size: 14,
              ),
              isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: QuestionText(
                text: 'Here is a second line',
                size: 18,
              ),
              subtitle: QuestionText(
                text: 'Here is a second line',
                size: 14,
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 72.0),
              title: Text('Three-line ListTile'),
              subtitle:
                  Text('A sufficiently long subtitle warrants three lines.'),
              isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('Two-line ListTile'),
              subtitle: Text('Here is a second line'),
            ),
          ),
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 72.0),
              title: Text('Three-line ListTile'),
              subtitle:
                  Text('A sufficiently long subtitle warrants three lines.'),
              isThreeLine: true,
            ),
          ),
        ],
      ),
    );
  }
}
