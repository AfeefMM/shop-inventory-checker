import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_mgmt/home/options_page2.dart';
import 'package:inventory_mgmt/model/item_colour.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:get/get.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';
import 'package:sql_conn/sql_conn.dart';

import '../home/display_page.dart';
import '../utils/size_convertor.dart';
import '../utils/sql_data.dart';
import 'btn_text.dart';

class DropdownBtn extends StatefulWidget {
  const DropdownBtn(
      {super.key,
      required this.styleCode,
      required this.option,
      required this.valueNotifier});
  final String styleCode;
  final String option;
  final ValueNotifier<String?> valueNotifier;
  @override
  State<DropdownBtn> createState() => _DropdownBtnState();
}

List<String> list2 = <String>[];
List<String> sizeList = <String>[];
List<String> sizeList2 = <String>[
  '00',
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '99'
];
List<ItemColour> list = [];

class _DropdownBtnState extends State<DropdownBtn> {
  String dropdownValue = "";
  @override
  void initState() {
    super.initState();
    fetchAndShow();
    fetchAndShowSizes();
  }

  static get styleCode => null;
  @override
  Widget build(BuildContext context) {
    if (widget.option == "colour") {
      return Container(
        child: DropdownButton<String>(
          value: widget.valueNotifier.value,
          //isExpanded: true,
          hint: Text('Show available colours'),

          elevation: 16,
          menuMaxHeight: Dimensions.heightDropDown,
          borderRadius: BorderRadius.circular(6),
          dropdownColor: AppColours.btnTextColour,
          underline: SizedBox(),
          style: const TextStyle(color: AppColours.btnColour),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              //dropdownValue = value!;
              widget.valueNotifier.value = value ?? "0";
            });
          },
          items: list2.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            );
          }).toList(),

          // items: list
          //     .map(
          //       (e) => DropdownMenuItem(
          //           value: e,
          //           child: Padding(
          //             padding: const EdgeInsets.fromLTRB(5, 1, 1, 1),
          //             child: Text(
          //               e.skcolr.toString(),
          //               style: const TextStyle(
          //                 fontSize: 16,
          //               ),
          //             ),
          //           )),
          //     )
          //     .toList(),
        ),
      );
      // Container(
      //   child: DropdownButton<String>(
      //     value: list2.first,
      //     //isExpanded: true,
      //     hint: Text('Search for colour'),
      //     elevation: 16,
      //     menuMaxHeight: Dimensions.heightDropDown,
      //     borderRadius: BorderRadius.circular(6),
      //     dropdownColor: AppColours.btnTextColour,
      //     underline: SizedBox(),
      //     style: const TextStyle(color: AppColours.btnColour),
      //     onChanged: (String? value) {
      //       // This is called when the user selects an item.
      //       setState(() {
      //         //dropdownValue = value!;
      //       });
      //     },
      //     items: list2.map<DropdownMenuItem<String>>((String value) {
      //       return DropdownMenuItem<String>(
      //         value: value,
      //         child: Text(value),
      //       );
      //     }).toList(),
      //     // items: list
      //     //     .map(
      //     //       (e) => DropdownMenuItem(
      //     //           value: e,
      //     //           child: Padding(
      //     //             padding: const EdgeInsets.fromLTRB(5, 1, 1, 1),
      //     //             child: Text(
      //     //               e.skcolr,
      //     //               style: const TextStyle(
      //     //                 fontSize: 16,
      //     //               ),
      //     //             ),
      //     //           )),
      //     //     )
      //     //     .toList(),
      //   ),
      // );
    } else {
      return Container(
        child: DropdownButton<String>(
          value: widget.valueNotifier.value,
          //isExpanded: true,
          hint: Text('Show available sizes'),

          elevation: 16,
          menuMaxHeight: Dimensions.heightDropDown,
          borderRadius: BorderRadius.circular(6),
          dropdownColor: AppColours.btnTextColour,
          underline: SizedBox(),
          style: const TextStyle(color: AppColours.btnColour),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              //dropdownValue = value!;
              widget.valueNotifier.value = value ?? "0";
            });
          },
          items: sizeList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: SizeConv.getSize(value),
              child: Text(
                SizeConv.getSize(value),
                style: TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
        ),
      );
    }
  }

//sql functions to obtain the colours

  Future<List<String>> getItemColours() async {
    try {
      await SqlConn.connect(
          ip: SQLData.ip,
          port: SQLData.port,
          databaseName: SQLData.databaseName,
          username: SQLData.username,
          password: SQLData.password);
      print("connected to server");
      var style = SQLData.getStyle(widget.styleCode);

      var result = await SqlConn.readData(SQLData.coloursQuery(style));
      if (result == '[]') {
        var snackBar = SnackBar(content: Text("colours not found"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var colours1 = result.replaceAll(RegExp(r'[^0-9,]'), '');
        print(colours1);
        var list2 = colours1.toString().split(",");
        return list2;
      }
    } catch (e) {
      print(e);
    }
    throw Exception('Failed to load');
  }

  Future<List<String>> getItemSizes() async {
    try {
      await SqlConn.connect(
          ip: SQLData.ip,
          port: SQLData.port,
          databaseName: SQLData.databaseName,
          username: SQLData.username,
          password: SQLData.password);
      print("connected to server");
      var style = SQLData.getStyle(widget.styleCode);

      var result = await SqlConn.readData(SQLData.getAvailableSizes(style));
      if (result == '[]') {
        var snackBar = SnackBar(content: Text("sizes not found"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var colours1 = result.replaceAll(RegExp(r'[^0-9,]'), '');
        print("sizes: " + colours1);
        var sList = colours1.toString().split(",");
        return sList;
      }
    } catch (e) {
      print(e);
    }
    throw Exception('Failed to load');
  }

  Future<void> fetchAndShowSizes() async {
    final sizes = await getItemSizes();
    setState(() {
      print("linked the size lists");
      sizeList = sizes;
    });
  }

  Future<void> fetchAndShow() async {
    final colours = await getItemColours();
    setState(() {
      print("linked the lists");
      list2 = colours;
    });
  }
}
/**
 
 */
