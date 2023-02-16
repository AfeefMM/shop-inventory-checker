import 'package:flutter/material.dart';

class SQLData {
  static const String ip = "192.168.0.50";
  static const String port = "1433";
  static const String databaseName = "TIGERPOS";
  static const String username = "sa";
  static const String password = "foxfire";

  static String getStyle(String id) {
    var style = "";
    style = id.substring(0, 8);
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

  static String getSQLStyle(String id) {
    var style = "";
    style = id.substring(4, 8);
    return style;
  }

  static String getSQLColour(String id) {
    var colour = "";
    colour = id.substring(8, 10);
    return colour;
  }

  static String getSQLSize(String id) {
    var size = "";
    size = id.substring(10);
    return size;
  }

  static String priceColourQuery(String style, String colour) {
    return "Select pcsprc from TIGERPOS.dbo.mfprch where pccolr like '${colour}' and pcstyl like '${style}%' order by pctxdt desc; ";
  }

  static String priceNormalQuery(String style) {
    return "Select top 1 pcsprc from TIGERPOS.dbo.mfprch where pccolr like '' and pcstyl like '${style}%' order by pctxdt desc; ";
  }

  static String coloursQuery(String style) {
    return "Select DISTINCT(skcolr) from TIGERPOS.dbo.mfskun and skstyl like '${style}%'";
  }
}
