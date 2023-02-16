import 'package:flutter/material.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

import '../utils/size_convertor.dart';
import '../utils/sql_data.dart';
import '../widgets/btn_text.dart';
import '../widgets/dropdown_button.dart';
import '../widgets/question_text.dart';
import '../widgets/searchBtn.dart';

class OptionsPage extends StatefulWidget {
  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  final ValueNotifier<String?> dropdownSize = ValueNotifier(null);
  final ValueNotifier<String?> dropdownColour = ValueNotifier(null);

  var args = Get.arguments[0].toString();
  var descItem = "";
  var argsStyle = Get.arguments[1];
  @override
  void initState() {
    // TODO: implement initState
    itemDesc(argsStyle);
    super.initState();
  }

  //var argsDesc = Get.arguments[2];
  @override
  Widget build(BuildContext context) {
    // print("argument desc:" + argsDesc);
    //  args = args.split(".")[0];
    var priceNum = args.replaceAll(RegExp(r'[^0-9.]'), '');
    var price = double.parse(priceNum);
    print("argument in next page: " + price.toStringAsFixed(2));

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
                  text: "AED " + price.toStringAsFixed(2),
                  size: 32,
                ),
              ),
            ],
          ),
          Spacer(),
          //textfield
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: QuestionText(
                  text: "Description",
                  size: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 350,
                child: QuestionText(
                  text: descItem,
                  size: 16,
                ),
              )
            ],
          ),
          Spacer(),
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
              Expanded(
                  child: Center(
                      child: DropdownBtn(
                styleCode: argsStyle,
                option: "colour",
                valueNotifier: dropdownColour,
              ))),
              Expanded(
                  child: Center(
                      child: DropdownBtn(
                styleCode: argsStyle,
                option: "",
                valueNotifier: dropdownSize,
              ))),
              // Expanded(child: Center(child: DropdownBtn())),
            ],
          ),
          Spacer(),
          //search all buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 10, 24),
                child: checkerBtn(),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(1, 1, 10, 24),
              //   child: SearchBtn(
              //     text: 'Search all sizes',
              //     option: 1,
              //   ),
              // ),
            ],
          ),
          // //promotions button

          Spacer()
        ],
      ),
    );
  }

  Future<void> itemDesc(style) async {
    print("attempting to connect");
    await SqlConn.connect(
        ip: SQLData.ip,
        port: SQLData.port,
        databaseName: SQLData.databaseName,
        username: SQLData.username,
        password: SQLData.password);

    print(SqlConn.isConnected);
    var descResult = await SqlConn.readData(SQLData.descQuery(style));
    print("description: " + descResult.toString());
    descResult =
        descResult.toString().substring(12, descResult.toString().length - 3);

    setState(() {
      descItem = descResult.toString();
    });
  }

  Widget checkerBtn() {
    //get value

    return OutlinedButton(
      onPressed: () async {
        //sql search to obtain availability of product code
        var size = dropdownSize.value ?? "0";
        size = SizeConv.getCode(size);
        var colour = dropdownColour.value ?? "0";
        print("attempting to connect");
        await SqlConn.connect(
            ip: SQLData.ip,
            port: SQLData.port,
            databaseName: SQLData.databaseName,
            username: SQLData.username,
            password: SQLData.password);

        print(SqlConn.isConnected);
        print("size " + size + " colour:  " + colour);
        var descResult = await SqlConn.readData(
            SQLData.checkAvailability(argsStyle, size, colour));
        print("number of stock: " + descResult.toString());
        descResult = descResult
            .toString()
            .substring(12, descResult.toString().length - 3);
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(24, 13, 24, 13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          backgroundColor: AppColours.btnColour,
          textStyle: TextStyle(color: AppColours.btnTextColour)),
      child: BtnText(
        text: "Check",
      ),
    );
  }
}
