import 'package:flutter/material.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';
import 'package:inventory_mgmt/widgets/btn_text.dart';

import '../widgets/question_text.dart';
import '../widgets/scanbtn.dart';
import '../widgets/searchBtn.dart';

class CodeEntryPage extends StatefulWidget {
  @override
  _CodeEntryPageState createState() => _CodeEntryPageState();
}

class _CodeEntryPageState extends State<CodeEntryPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //text
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 4, 10),
                child: QuestionText(
                  text: 'Enter code manually',
                  size: 14,
                ),
              ),
            ],
          ),
          //textfield
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 375,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'WorkSans',
                        color: AppColours.text2Color),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '12 digit code',
                    ),
                  ),
                ),
              ),
            ],
          ),
          //search button
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 24, 1, 24),
                child: SearchBtn(
                  text: 'Search',
                  option: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 1, 24),
                child: ScanBtn(
                  text: 'Scan barcode',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
