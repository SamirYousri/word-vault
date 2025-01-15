import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';

abstract class ThemeManager {
  static ThemeData getAppTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.black,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        backgroundColor: ColorManager.black,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: ColorManager.black),
      ),
    );
  }
}
