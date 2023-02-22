import 'package:flutter/material.dart';
import 'package:inventory_mgmt/home/table_view.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

import '../utils/size_convertor.dart';
import '../utils/sql_data.dart';
import '../widgets/btn_text.dart';
import '../widgets/dropdown_button.dart';
import '../widgets/question_text.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  final ValueNotifier<String?> dropdownSize = ValueNotifier(null);
  final ValueNotifier<String?> dropdownColour = ValueNotifier(null);

  String availVal = "0";

  var args = Get.arguments[0].toString();
  var descItem = "";
  var argsStyle = Get.arguments[1];
  var argsColour = Get.arguments[2];
  var argsSize = Get.arguments[3];
  @override
  void initState() {
    // TODO: implement initState
    itemDesc(argsStyle);
    onStartInv(argsStyle, argsSize, argsColour);
    // print("argument : " + argsStyle);
    super.initState();
  }

  //var argsDesc = Get.arguments[2];
  @override
  Widget build(BuildContext context) {
    // print("argument desc:" + argsDesc);
    //  args = args.split(".")[0];
    var priceNum = args.replaceAll(RegExp(r'[^0-9.]'), '');
    var price = double.parse(priceNum);
    // print("argument in next page: " + price.toStringAsFixed(2));

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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.67,
            child: Divider(
              color: AppColours.btnColour,
            ),
          ),
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.67,
            child: Divider(
              color: AppColours.btnColour,
            ),
          ),
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.67,
            child: Divider(
              color: AppColours.btnColour,
            ),
          ),
          //search all buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 1, 10, 24),
                    child: checkerBtn(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 1, 10, 24),
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => DisplayTablePage(), arguments: argsStyle);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(24, 13, 24, 13),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0)),
                          backgroundColor: AppColours.btnColour,
                          textStyle:
                              TextStyle(color: AppColours.btnTextColour)),
                      child: BtnText(
                        text: "Check for all",
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: QuestionText(text: "Available stock: " + availVal),
              ),
            ],
          ),
          // //promotions button
        ],
      ),
    );
  }

  Future<void> onStartInv(argsStyle, size, colour) async {
    await SqlConn.connect(
        ip: SQLData.ip,
        port: SQLData.port,
        databaseName: SQLData.databaseName,
        username: SQLData.username,
        password: SQLData.password);

    print(SqlConn.isConnected);
    var descResult = await SqlConn.readData(
        SQLData.checkAvailability(argsStyle, size, colour));

    setState(() {
      availVal = descResult.replaceAll(RegExp(r'[^0-9.]'), '');
    });
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
    //print("description: " + descResult.toString());
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
        var descResult = await SqlConn.readData(
            SQLData.checkAvailability(argsStyle, size, colour));
        print("number of stock: " + descResult.toString());

        setState(() {
          availVal = descResult.replaceAll(RegExp(r'[^0-9.]'), '');
          _showAlert(" stock left = " + availVal);
        });

        SqlConn.disconnect();
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

  Future<void> _showAlert(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Stock Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Back'),
              style: TextButton.styleFrom(
                foregroundColor: AppColours.btnColour,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
