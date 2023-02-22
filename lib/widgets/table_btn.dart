import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_conn/sql_conn.dart';

import '../home/table_view.dart';
import '../utils/colours.dart';
import '../utils/dimensions.dart';
import '../utils/sql_data.dart';
import 'btn_text.dart';

class TableBtn extends StatefulWidget {
  Color? color;
  final String text;
  final String args;
  double size;
  TextOverflow overflow;
  TableBtn(
      {Key? key,
      this.color = AppColours.btnTextColour,
      required this.text,
      required this.args,
      this.overflow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);

  @override
  State<TableBtn> createState() => _TableBtnState();
}

class _TableBtnState extends State<TableBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: OutlinedButton(
        onPressed: () async {
          /*
          print("attempting to connect");
          await SqlConn.connect(
              ip: SQLData.ip,
              port: SQLData.port,
              databaseName: SQLData.databaseName,
              username: SQLData.username,
              password: SQLData.password);

          print(SqlConn.isConnected);
          var itemsResult =
              await SqlConn.readData(SQLData.getAvailableCount(widget.args));
          SqlConn.disconnect();
          print("items: " + itemsResult);
          if (itemsResult == '[]') {
            var snackBar = SnackBar(content: Text("Style has no inventory"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            Get.to(() => DisplayTablePage(), arguments: widget.args);
          }*/
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.fromLTRB(24, 13, 24, 13),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            backgroundColor: AppColours.btnColour,
            textStyle: TextStyle(color: AppColours.btnTextColour)),
        child: BtnText(
          text: widget.text,
        ),
      ),
    );
  }

  Future<bool> getItemsCount(style) async {
    return true;
  }
}
