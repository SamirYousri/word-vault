import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';

Center getLoading() {
  return Center(
    child: CircularProgressIndicator(
      color: ColorManager.white,
    ),
  );
}
