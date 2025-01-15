import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key, this.onTap, required this.colorCode});
  final int colorCode;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorManager.white,
          ),
          child: Center(
            child: Text(
              'Done',
              style: TextStyle(
                color: Color(colorCode),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
