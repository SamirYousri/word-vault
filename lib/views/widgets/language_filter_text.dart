import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit_states.dart';

class LanguageFilterText extends StatelessWidget {
  const LanguageFilterText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataCubit, GetDataCubitStates>(
      builder: (context, state) {
        return Text(
          _getStringLanguageFilterFromEnum(
              GetDataCubit.get(context).languageFilter),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: ColorManager.white,
          ),
        );
      },
    );
  }

  String _getStringLanguageFilterFromEnum(LanguageFilter languageFilter) {
    if (languageFilter == LanguageFilter.allWords) {
      return 'All Words';
    } else if (languageFilter == LanguageFilter.arabicWordsOnly) {
      return 'Arabic Only';
    } else {
      return 'English Only';
    }
  }
}
