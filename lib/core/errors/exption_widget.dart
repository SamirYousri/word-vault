import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';

class ExptionWidget extends StatelessWidget {
  const ExptionWidget({super.key, required this.text, required this.iconData});
  final String text;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Icon(
          iconData,
          color: ColorManager.white,
          size: 100,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: ColorManager.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
