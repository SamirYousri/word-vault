import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';
import 'package:vocabulary_notes_app/views/widgets/filter_dialog.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => FilterDialog(),
        );
      },
      child: CircleAvatar(
        backgroundColor: ColorManager.white,
        radius: 20,
        child: Center(
          child: Icon(
            Icons.filter_list,
            color: ColorManager.black,
            size: 30,
          ),
        ),
      ),
    );
  }
}
