import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit.dart';

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({super.key, required this.activeColorCode});
  final int activeColorCode;
  final List<int> _colorsCode = const [
    0XFF4A47A3,
    0XFF0C7B93,
    0XFF892CDC,
    0XFFBC6FF1,
    0XFFF4ABC4,
    0XFFC70039,
    0XFF8FBCBF,
    0XFFFA8072,
    0XFF4D4C7D,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _colorsCode.length,
        itemBuilder: (context, index) {
          return colorItem(index, context);
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
      ),
    );
  }

  Widget colorItem(int index, BuildContext context) {
    return GestureDetector(
      onTap: () =>
          OperationsOnDataCubit.get(context).updateColor(_colorsCode[index]),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Color(_colorsCode[index]),
          shape: BoxShape.circle,
          border: activeColorCode == _colorsCode[index]
              ? Border.all(color: ColorManager.white, width: 2)
              : null,
        ),
        child: activeColorCode == _colorsCode[index]
            ? Icon(
                Icons.done,
                color: ColorManager.white,
              )
            : null,
      ),
    );
  }
}
