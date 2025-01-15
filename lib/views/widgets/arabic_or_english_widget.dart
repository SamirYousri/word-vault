import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget(
      {super.key, required this.colorCode, required this.isArabic});
  final int colorCode;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        getLanguageItem(true, context),
        getLanguageItem(false, context),
      ],
    );
  }

  InkWell getLanguageItem(bool buildIsArabic, BuildContext context) {
    return InkWell(
      onTap: () =>
          OperationsOnDataCubit.get(context).updateIsArabic(buildIsArabic),
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorManager.white, width: 2),
          color:
              buildIsArabic == isArabic ? ColorManager.white : Color(colorCode),
        ),
        child: Center(
          child: Text(
            buildIsArabic ? 'ar' : 'en',
            style: TextStyle(
              color: buildIsArabic == isArabic
                  ? Color(colorCode)
                  : ColorManager.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
