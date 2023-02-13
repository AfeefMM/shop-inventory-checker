import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_mgmt/home/code_entry.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:get/get.dart';

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
      onPressed: () async {
        try {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Cancel", false, ScanMode.DEFAULT);
          print(barcodeScanRes);
          Get.to(() => CodeEntryPage(), arguments: barcodeScanRes);
        } catch (e) {
          print(e.toString());
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
  }
}
