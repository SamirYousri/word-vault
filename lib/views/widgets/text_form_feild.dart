import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit.dart';

class TextFormFeild extends StatelessWidget {
  const TextFormFeild({super.key, required this.formKey, required this.label});

  final GlobalKey<FormState> formKey;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        autofocus: true,
        onChanged: (value) =>
            OperationsOnDataCubit.get(context).updateText(value),
        validator: (value) {
          return _validator(
            value,
            OperationsOnDataCubit.get(context).isArabic,
          );
        },
        cursorColor: ColorManager.white,
        style: TextStyle(color: ColorManager.white),
        maxLines: 3,
        minLines: 1,
        decoration: InputDecoration(
          label: Text(
            label,
            style: TextStyle(
              color: ColorManager.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          enabledBorder: _getOutLineInputBorder(ColorManager.white),
          focusedBorder: _getOutLineInputBorder(ColorManager.white),
          errorBorder: _getOutLineInputBorder(ColorManager.red),
          focusedErrorBorder: _getOutLineInputBorder(ColorManager.red),
        ),
      ),
    );
  }

  String? _validator(String? value, bool isArabic) {
    if (value == null || value.trim().isEmpty) {
      return 'The field is empty, fill the field';
    }
    for (var i = 0; i < value.length; i++) {
      CharType charType = _getCharType(value.codeUnitAt(i));
      if (charType == CharType.arabic && isArabic == false) {
        return 'Char number ${i + 1} is not english char';
      } else if (charType == CharType.english && isArabic == true) {
        return 'Char number ${i + 1} is not arabic char';
      } else if (charType == CharType.notValid) {
        return 'Char number ${i + 1} is not valid char';
      }
    }
    return null;
  }

  OutlineInputBorder _getOutLineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

CharType _getCharType(int asciiCode) {
  if ((asciiCode >= 65 && asciiCode <= 90) ||
      (asciiCode >= 97 && asciiCode <= 122)) {
    return CharType.english;
  } else if (asciiCode >= 1569 && asciiCode <= 1610) {
    return CharType.arabic;
  } else if (asciiCode == 32) {
    return CharType.space;
  } else {
    return CharType.notValid;
  }
}

enum CharType {
  arabic,
  english,
  space,
  notValid,
}
