import 'package:flutter/material.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';

import '../widgets/dropdown_button.dart';
import '../widgets/question_text.dart';
import '../widgets/searchBtn.dart';

class OptionsPage extends StatelessWidget {
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuestionText(text: 'Select a colour'),
              QuestionText(text: 'Select a size'),
            ],
          ),
          //search each button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Center(child: DropdownBtn())),
              Expanded(child: Center(child: DropdownBtn())),
            ],
          ),
          Spacer(),
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

          Spacer()
        ],
      ),
    );
  }
}
