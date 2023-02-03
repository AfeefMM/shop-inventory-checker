import 'package:flutter/material.dart';
import 'package:inventory_mgmt/utils/colours.dart';

import '../utils/dimensions.dart';

class QuestionText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  QuestionText(
      {Key? key,
      this.color = AppColours.textColor,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w400,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.font20 : size,
          fontWeight: fontWeight,
          fontFamily: 'WorkSans'
          //fontFamily: 'Roboto', add font family to assets folder then to pubsec.yaml
          ),
    );
  }
}
