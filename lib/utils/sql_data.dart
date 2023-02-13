import 'package:flutter/material.dart';

class SQLData {
  static const String ip = "192.168.128.176";
  static const String port = "1433";
  static const String databaseName = "MDCData";
  static const String username = "AS";
  static const String password = "112233";

  static String getStyle(String id) {
    var style = "";
    style = id.substring(4, 8);
    return style;
  }

  static String getColour(String id) {
    var colour = "";
    colour = id.substring(8, 10);
    return colour;
  }

  static String getSize(String id) {
    var size = "";
    size = id.substring(10);
    return size;
  }
}
