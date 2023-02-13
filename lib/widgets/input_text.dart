import 'package:flutter/material.dart';
import 'package:inventory_mgmt/utils/colours.dart';

import '../utils/dimensions.dart';

class InputText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  InputText(
      {Key? key,
      this.color = AppColours.textColor,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w400,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      child: Padding(
        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: TextField(
          style: TextStyle(
              fontSize: 12,
              fontWeight: fontWeight,
              fontFamily: 'WorkSans',
              color: AppColours.text2Color),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: '12 digit code' == "" ? text : text,
          ),
        ),
      ),
    );
  }
}

//fontSize: size == 0 ? Dimensions.font20 : size,
