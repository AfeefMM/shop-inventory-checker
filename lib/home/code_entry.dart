// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:inventory_mgmt/model/item_price.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';
import 'package:inventory_mgmt/utils/sql_data.dart';
import 'package:inventory_mgmt/widgets/btn_text.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:sql_conn/sql_conn.dart';

import '../widgets/question_text.dart';
import 'options_page2.dart';

class CodeEntryPage extends StatefulWidget {
  @override
  State<CodeEntryPage> createState() => _CodeEntryPageState();
}

class _CodeEntryPageState extends State<CodeEntryPage> {
  TextEditingController itemCodeController = TextEditingController();
  String _scanBarcode = 'Enter code';
  bool isBarcode = false;
  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.DEFAULT);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      isBarcode = true;
      _scanBarcode = barcodeScanRes;

      print("var updated");
    });
    try {
      var itemVal = barcodeScanRes;
      print("attempting to connect");
      await SqlConn.connect(
          ip: SQLData.ip,
          port: SQLData.port,
          databaseName: SQLData.databaseName,
          username: SQLData.username,
          password: SQLData.password);

      print(SqlConn.isConnected);
      var snackBar = SnackBar(content: Text("connected"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      var style = SQLData.getStyle(itemVal),
          colour = SQLData.getColour(itemVal),
          size = SQLData.getSize(itemVal);
      print("connected");
      print("sent query");
      var result =
          await SqlConn.readData(SQLData.priceColourQuery(style, colour));
      if (result == '[]') {
        result = await SqlConn.readData(SQLData.priceNormalQuery(style));
        print("executes 2nd query");
        if (result == '[]') {
          print("not found");

          var snackBar = SnackBar(content: Text("item not found"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          print("result: " + result.toString());
          Get.to(() => OptionsPage(),
              arguments: [result.toString(), style, colour, size]);
        }
      } else {
        print("result: " + result.toString());
        Get.to(() => OptionsPage(),
            arguments: [result.toString(), style, colour, size]);
      }

      SqlConn.disconnect();
      print(SqlConn.isConnected);
    } catch (e) {
      print(e);
    }
  }

  Widget barcodeScanner(text) {
    return OutlinedButton(
      onPressed: () async {
        barcodeScan();
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
      body: Builder(builder: (context) {
        return Column(
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
              children: [
                SizedBox(
                  width: 375,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                    child: TextField(
                      controller: itemCodeController,
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (value) {
                        if (value.length != 12) {}
                      },
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'WorkSans',
                          color: AppColours.text2Color),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: _scanBarcode,
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
                  child: searchBtn('Search', itemCodeController.text),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(1, 1, 1, 24),
                  child: barcodeScanner(
                    'Scan barcode',
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget searchBtn(text, itemVal) {
    return OutlinedButton(
      onPressed: () async {
        setState(() {
          itemVal = itemCodeController.text;
        });
        //add codeNum logic
        //sql search to obtain details of product code
        // Get.to(() => OptionsPage());
        try {
          print("attempting to connect");
          await SqlConn.connect(
              ip: SQLData.ip,
              port: SQLData.port,
              databaseName: SQLData.databaseName,
              username: SQLData.username,
              password: SQLData.password);

          print(SqlConn.isConnected);
          var snackBar = SnackBar(content: Text("connected"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          var style = SQLData.getStyle(itemVal),
              colour = SQLData.getColour(itemVal),
              size = SQLData.getSize(itemVal);
          print("connected");
          print("sent query");
          var result =
              await SqlConn.readData(SQLData.priceColourQuery(style, colour));
          if (result == '[]') {
            result = await SqlConn.readData(SQLData.priceNormalQuery(style));
            print("executes 2nd query");
            if (result == '[]') {
              print("not found");

              var snackBar = SnackBar(content: Text("item not found"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              print("result: " + result.toString());
              var descResult = await SqlConn.readData(SQLData.descQuery(style));
              print("description: " + descResult.toString());
              Get.to(() => OptionsPage(),
                  arguments: [result.toString(), style]);
            }
          } else {
            print("result: " + result.toString());
            Get.to(() => OptionsPage(), arguments: [result.toString(), style]);
          }

          SqlConn.disconnect();
          print(SqlConn.isConnected);
        } catch (e) {
          print(e);
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

  // Future<String> getPrice(String style, String colour, String size) async {
  //   print("sent query");
  //   var result = await conn.execute(
  //       "Select pcsprc from TIGERPOS.dbo.mfprch WHERE pcstyle LIKE ‘$style%’ AND pccolr LIKE ‘$colour AND pcsize LIKE ‘$size’");
  //   print("result: " + result);
  //   return "result";
  // }

  // first 8 digits are style
  //next 2 digits are colour
  //last 2 digits are size
  //pass 8 digits as pcstyle check for first 8 digits under the pcstyl column

  //select * from TIGEROS.dbo.mfprch where pcstyl like '01010026%'; -> for price where 8 digit style code is that
// where pcsize <> '' -> for not empty columns
  //pccolr like '%0%'- for any col with a 0
}
