import 'package:flutter/material.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';
import 'package:get/get.dart';

import '../widgets/question_text.dart';

class DescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var value = Get.arguments;
    print(value);
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
          Image(
            height: Dimensions.heightImg,
            width: Dimensions.widthImg,
            image: const NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 50, 1, 1),
                child: QuestionText(
                  text: value[0].toString(),
                  size: 32,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 1, 1),
                child: QuestionText(
                  text: 'Product Description',
                  fontWeight: FontWeight.w800,
                  size: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 1, 1),
                child: QuestionText(
                  text: 'Brand:',
                  size: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 1, 1),
                child: QuestionText(
                  text: 'Category:',
                  size: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 1, 1),
                child: QuestionText(
                  text: 'Style:',
                  size: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 1, 1),
                child: QuestionText(
                  text: 'Colour:',
                  size: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 1, 1),
                child: QuestionText(
                  text: 'Size:',
                  size: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
