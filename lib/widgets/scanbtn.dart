import 'package:flutter/material.dart';
import 'package:inventory_mgmt/utils/colours.dart';

import 'btn_text.dart';

class ScanBtn extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  ScanBtn(
      {Key? key,
      this.color = AppColours.btnColour,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(24, 13, 24, 13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          backgroundColor: AppColours.btnColour,
          textStyle: TextStyle(color: AppColours.btnTextColour)),
      child: BtnText(
        text: text,
      ),
    );
  }
}
