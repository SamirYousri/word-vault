import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';

class UpdateWordButton extends StatelessWidget {
  const UpdateWordButton({
    super.key,
    required this.color,
    required this.onTap,
  });
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.add,
          color: ColorManager.black,
          size: 25,
        ),
      ),
    );
  }
}
