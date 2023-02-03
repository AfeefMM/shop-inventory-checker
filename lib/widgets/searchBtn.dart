import 'package:flutter/material.dart';
import 'package:inventory_mgmt/home/options_page2.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:get/get.dart';

import '../home/display_page.dart';
import 'btn_text.dart';

class SearchBtn extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  int option;
  SearchBtn(
      {Key? key,
      this.color = AppColours.btnColour,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.size = 0,
      this.option = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (option == 0) {
          Get.to(() => OptionsPage());
        } else if (option == 1) {
          Get.to(() => DisplayPage());
        }
      },
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
    // TextButton(

    //   style: ButtonStyle(
    //     foregroundColor: MaterialStateProperty.all<Color>(AppColours.btnColour),
    //     backgroundColor: MaterialStateProperty.all<Color>(AppColours.btnColour),
    //   ),

    //   onPressed: () {},
    //   child: BtnText(
    //     text: text,
    //   ),
    // );
  }
}
