import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

import '../model/cloth_item.dart';

class SQLController extends GetxController {
  List _data = [];
  var todos = <ClothItem>[].obs;

  @override
  void onInit() {
    // _data = read() as List;
    super.onInit();
  }

  Future<void> connect() async {
    try {
      await SqlConn.connect(
          ip: "192.168.128.176",
          port: "1433",
          databaseName: "MDCData",
          username: "AS",
          password: "112233");
      debugPrint("Connected!");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> read(String query) async {
    var res = await SqlConn.readData(query);
    return res;
    debugPrint(res.toString());
  }
}
