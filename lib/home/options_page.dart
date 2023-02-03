import 'package:flutter/material.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';
import 'package:inventory_mgmt/widgets/btn_text.dart';

import '../widgets/question_text.dart';
import '../widgets/scanbtn.dart';
import '../widgets/searchBtn.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //text
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 75, 4, 10),
                child: QuestionText(
                  text: 'Price of item:',
                  size: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(75, 75, 1, 10),
                child: QuestionText(
                  text: '100 AED',
                  size: 32,
                ),
              ),
            ],
          ),
          Spacer(),
          //textfield
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 375,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 40),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'WorkSans',
                        color: AppColours.text2Color),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search Bar',
                    ),
                  ),
                ),
              ),
            ],
          ),
          //search each button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 10, 24),
                child: SearchBtn(
                  text: 'Search for colour',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 10, 24),
                child: SearchBtn(
                  text: 'Search for size',
                ),
              ),
            ],
          ),
          //search all buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 10, 24),
                child: SearchBtn(
                  text: 'Search all colours',
                  option: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 10, 24),
                child: SearchBtn(
                  text: 'Search all sizes',
                  option: 1,
                ),
              ),
            ],
          ),
          //promotions button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 10, 24),
                child: SearchBtn(
                  text: 'Check for promotions',
                ),
              ),
            ],
          ),

          Spacer()
        ],
      ),
    );
  }
}
