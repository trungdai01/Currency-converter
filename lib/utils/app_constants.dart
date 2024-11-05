import 'dart:ui';
import 'package:flutter/material.dart';

class AppConstants {
  static const String baseURL = "cdn.jsdelivr.net";
  static const String currenciesURL = "/npm/@fawazahmed0/currency-api@latest/v1/currencies.json";
  static const String ratesURL = "/npm/@fawazahmed0/currency-api@latest/v1/currencies/";
}

class AppColors {
  static const Color mainColor = Color(0xff212936);
  static const Color secondColor = Color(0xff2849e5);
}

class Dimension {
  static FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
  static Size size = view.physicalSize;

  static double screenHeight = size.height;
  static double screenWidth = size.width;

  static double font16 = screenHeight / 146.0625;
  static double font18 = screenHeight / 129.833;
  static double font20 = screenHeight / 116.85;
  static double font24 = screenHeight / 97.375;
  static double font26 = screenHeight / 89.88;
  static double font36 = screenHeight / 64.92;
  static double font40 = screenHeight / 58.425;

  static double height5 = screenHeight / 467.4;
  static double height10 = screenHeight / 233.7;
  static double height15 = screenHeight / 155.8;
  static double height40 = screenHeight / 58.425;

  static double width10 = screenHeight / 233.7;
  static double width15 = screenHeight / 155.8;

  static double radius5 = screenHeight / 467.4;
  static double radius8 = screenHeight / 292.125;
}
