import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';

class WordInfo extends StatelessWidget {
  const WordInfo(
      {super.key,
      required this.color,
      required this.isArabic,
      required this.text,
      this.onTap});
  final String text;
  final Color color;
  final bool isArabic;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Row(
        spacing: 10,
        children: [
          _getCircleAvatar(),
          _getText(),
          if (onTap != null)
            IconButton(
              onPressed: onTap,
              icon: const Icon(
                Icons.delete,
                color: ColorManager.black,
                size: 30,
              ),
            )
        ],
      ),
    );
  }

  CircleAvatar _getCircleAvatar() {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorManager.black,
      child: Text(
        isArabic ? 'ar' : 'en',
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Expanded _getText() {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(
          color: ColorManager.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
