import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';
import 'package:inventory_mgmt/utils/sql_data.dart';
import 'package:inventory_mgmt/widgets/btn_text.dart';
import 'package:sql_conn/sql_conn.dart';

import '../widgets/input_text.dart';
import '../widgets/question_text.dart';
import '../widgets/scanbtn.dart';
import '../widgets/searchBtn.dart';

class CodeEntryPage extends StatefulWidget {
  @override
  State<CodeEntryPage> createState() => _CodeEntryPageState();
}

class _CodeEntryPageState extends State<CodeEntryPage> {
  String _scanBarcode = 'Enter code';

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
      _scanBarcode = barcodeScanRes;
      print("var updated");
    });
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
                  child: searchBtn('Search', _scanBarcode),
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
        //add codeNum logic
        //sql search to obtain details of product code

        try {
          await SqlConn.connect(
              ip: SQLData.ip,
              port: SQLData.port,
              databaseName: SQLData.databaseName,
              username: SQLData.username,
              password: SQLData.password);

          var price = getPrice(SQLData.getStyle(_scanBarcode),
              SQLData.getColour(_scanBarcode), SQLData.getSize(_scanBarcode));
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

  Future<String> getPrice(String style, String colour, String size) async {
    var result = await SqlConn.readData(
        "select pcsprc from TIGERPOS.dbo.mfprch where pcstyl = ");
    return result;
  }
  // first 8 digits are style
  //next 2 digits are colour
  //last 2 digits are size
  //pass 8 digits as pcstyle check for first 8 digits under the pcstyl column

  //select * from TIGEROS.dbo.mfprch where pcstyl like '01010026%'; -> for price where 8 digit style code is that
// where pcsize <> '' -> for not empty columns
  //pccolr like '%0%'- for any col with a 0
}
