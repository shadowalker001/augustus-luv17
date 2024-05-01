// ignore_for_file: file_names

import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static Color appColor = const Color(0xB8FF016B);
  static Color appColorAlt = const Color(0xFFcca82c);
  static List<Color> gradient = [
    const Color(0xB845FFF4),
    const Color(0xB87000FF)
  ];
  bool isDarkTheme = false;

  Color main = const Color(0xB8FF016B);
  Color mainAlt = const Color(0xFFcca82c);
  Color btn = const Color(0xFF16619E);
  Color btnAlt = const Color(0xFF5244ab);
  Color mainMinor = Colors.white;
  Color minor = Colors.white;
  Color minorMain = Colors.black;
  Color? searchText = Colors.black;
  Color subText = Colors.grey;
  Color minorMinor = const Color(0xffeeeeee);
  Color tab = Colors.grey;
  Color active = appColor;
}
