import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_mgmt/utils/colours.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home/code_entry.dart';
import 'home/description.dart';
import 'home/display_page.dart';
import 'home/options_page2.dart';
import 'widgets/dropdown_button.dart';

void main() {
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: DropdownBtn(
          styleCode: '01048024',
        ),
        image: new Image.asset('assets/Giordano-logo 1.png'),
        photoSize: 100.0,
        backgroundColor: AppColours.mainColor,
        styleTextUnderTheLoader: new TextStyle(),
        loaderColor: AppColours.mainColor);
  }
}
