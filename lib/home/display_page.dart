// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_mgmt/home/description.dart';
import 'package:inventory_mgmt/model/cloth_item.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

import '../utils/sql_data.dart';

class DisplayPage extends StatefulWidget {
  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
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
        body: ListView.builder(
            itemCount: listIVSKUN.length,
            itemBuilder: ((BuildContext context, int index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    // Get.to(() => DescriptionPage(),
                    //     arguments: [list1.elementAt(index).toString()]);
                  },
                  //leading: FlutterLogo(size: 72.0),
                  title: Text("style code: " +
                      listIVSKUN.elementAt(index).toString().substring(0, 8) +
                      listIVSKUN.elementAt(index).toString().substring(11)),
                  subtitle: Text("inventory of item: " +
                      listIVONHD.elementAt(index).toString()),
                  isThreeLine: true,
                ),
              );
            })));
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
    var itemsResult = await SqlConn.readData(SQLData.getAvailableItems(style));

    setState(() {
      listIVSKUN = getStyleCode(itemsResult, true);
    });
  }

  getStyleCode(code, isStyle) {
    var styles = code.replaceAll(RegExp(r'[^0-9,]'), '');
    print(styles);
    var styleList = styles.toString().split(",");
    if (isStyle) {}
    return styleList;
    print(styles);
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
    var itemsResult = await SqlConn.readData(SQLData.getAvailableCount(style));

    setState(() {
      listIVONHD = getStyleCode(itemsResult, false);
    });
  }
}

var list = {
  'tee': 'black',
  'print tee': 'white',
  'pant': 'beige',
  'hoodie': 'orange'
};

var list1 = new List<int>.generate(20, (i) => i + 1);
