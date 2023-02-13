import 'package:flutter/material.dart';
import 'package:inventory_mgmt/home/description.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:get/get.dart';

class DisplayPage extends StatelessWidget {
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
            itemCount: list1.length,
            itemBuilder: ((BuildContext context, int index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Get.to(() => DescriptionPage(),
                        arguments: [list1.elementAt(index).toString()]);
                  },
                  leading: FlutterLogo(size: 72.0),
                  title: Text(list1.elementAt(index).toString()),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  isThreeLine: true,
                ),
              );
            })));
  }
}

var list = {
  'tee': 'black',
  'print tee': 'white',
  'pant': 'beige',
  'hoodie': 'orange'
};
var list2 = [1, 2, 3, 4, 5];
var list1 = new List<int>.generate(20, (i) => i + 1);
