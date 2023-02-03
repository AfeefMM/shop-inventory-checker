import 'package:flutter/material.dart';
import 'package:inventory_mgmt/home/options_page2.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:get/get.dart';
import 'package:inventory_mgmt/utils/dimensions.dart';

import '../home/display_page.dart';
import 'btn_text.dart';

class DropdownBtn extends StatefulWidget {
  const DropdownBtn({super.key});

  @override
  State<DropdownBtn> createState() => _DropdownBtnState();
}

const List<String> list = <String>[
  'One',
  'Two',
  'Three',
  'Four',
  'Five',
  'Six',
  'Seven',
  'Eight',
  'Nine',
  '10',
  '11',
  '12',
  '13'
];

class _DropdownBtnState extends State<DropdownBtn> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      //isExpanded: true,
      hint: Text('Search for colour'),

      elevation: 16,
      menuMaxHeight: Dimensions.heightDropDown,
      borderRadius: BorderRadius.circular(6),
      dropdownColor: AppColours.btnTextColour,
      underline: SizedBox(),
      style: const TextStyle(color: AppColours.btnColour),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
