// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_mgmt/home/description.dart';
import 'package:inventory_mgmt/model/cloth_item.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:get/get.dart';
import 'package:inventory_mgmt/widgets/question_text.dart';
import 'package:sql_conn/sql_conn.dart';

import '../utils/sql_data.dart';

class DisplayTablePage extends StatefulWidget {
  const DisplayTablePage({super.key, this.checker = ""});

  @override
  State<DisplayTablePage> createState() => _DisplayTablePageState();

  final String checker;
}

class _DisplayTablePageState extends State<DisplayTablePage> {
  var listIVSKUN = [];
  var listIVONHD = [];
  var styleCode = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemsStyle(styleCode);
    getItemsCount(styleCode);
  }

  @override
  Widget build(BuildContext context) {
    print("val = " + styleCode);
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: QuestionText(
                  text: "Style code: " + styleCode,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: DataTable(
                    border:
                        TableBorder.all(color: AppColours.btnColour, width: 2),
                    columnSpacing: MediaQuery.of(context).size.width / 2.5,
                    horizontalMargin: 12,
                    columns: const [
                      DataColumn(
                        label: Expanded(child: Text('Style - Colour - Size')),
                      ),
                      DataColumn(
                        label: Expanded(child: Text('On hand')),
                      ),
                    ],
                    rows: List.generate(listIVSKUN.length, (index) {
                      final y = listIVSKUN[index];

                      final x = listIVONHD[index];

                      return DataRow(cells: [
                        DataCell(Container(
                            child: Text(listIVSKUN
                                    .elementAt(index)
                                    .toString()
                                    .substring(0, 8) +
                                " " +
                                listIVSKUN
                                    .elementAt(index)
                                    .toString()
                                    .substring(11, 13) +
                                " " +
                                listIVSKUN
                                    .elementAt(index)
                                    .toString()
                                    .substring(13)))),
                        DataCell(Container(child: Text(x))),
                      ]);
                    }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> getItemsStyle(style) async {
    print("attempting to connect");
    await SqlConn.connect(
        ip: SQLData.ip,
        port: SQLData.port,
        databaseName: SQLData.databaseName,
        username: SQLData.username,
        password: SQLData.password);

    print(SqlConn.isConnected);
    late var itemsResult;
    if (widget.checker == "") {
      itemsResult = await SqlConn.readData(SQLData.getAvailableItems(style));
    } else {
      itemsResult = await SqlConn.readData(
          SQLData.getAvailableItemswithColour(style, widget.checker));
    }
    print("itemsResult: " + itemsResult);
    setState(() {
      listIVSKUN = getStyleCode(itemsResult, true);
    });
    SqlConn.disconnect();
  }

  getStyleCode(code, isStyle) {
    var styles = code.replaceAll(RegExp(r'[^0-9,]'), '');

    var styleList = styles.toString().split(",");
    if (isStyle) {}
    return styleList;
  }

  Future<void> getItemsCount(style) async {
    print("attempting to connect");
    await SqlConn.connect(
        ip: SQLData.ip,
        port: SQLData.port,
        databaseName: SQLData.databaseName,
        username: SQLData.username,
        password: SQLData.password);

    print(SqlConn.isConnected);

    late var itemsResult;
    if (widget.checker != "") {
      itemsResult = await SqlConn.readData(
          SQLData.getAvailableCountwithColour(style, widget.checker));
    } else {
      itemsResult = await SqlConn.readData(SQLData.getAvailableCount(style));
    }

    setState(() {
      listIVONHD = getStyleCode(itemsResult, false);
    });
    SqlConn.disconnect();
  }
}

var list = {
  'tee': 'black',
  'print tee': 'white',
  'pant': 'beige',
  'hoodie': 'orange'
};

var list1 = new List<int>.generate(20, (i) => i + 1);
