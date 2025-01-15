import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit_states.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataCubit, GetDataCubitStates>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: ColorManager.black,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                getText('Language'),
                getLanguageFilter(context),
                SizedBox(
                  height: 5,
                ),
                getText('Sorted By'),
                getSortedBy(context),
                SizedBox(
                  height: 5,
                ),
                getText('Sorting Type'),
                getSortingType(context),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getSortingType(BuildContext context) {
    return _getButtonFilter(
      lables: ['Ascending', 'Descending'],
      onTaps: [
        () =>
            GetDataCubit.get(context).updateSortingType(SortingType.ascending),
        () =>
            GetDataCubit.get(context).updateSortingType(SortingType.descending),
      ],
      selectedButtons: [
        GetDataCubit.get(context).sortingType == SortingType.ascending,
        GetDataCubit.get(context).sortingType == SortingType.descending,
      ],
    );
  }

  Widget getSortedBy(BuildContext context) {
    return _getButtonFilter(
      lables: ['Time', 'Word Length'],
      onTaps: [
        () => GetDataCubit.get(context).updateSortedBy(SortedBy.time),
        () => GetDataCubit.get(context).updateSortedBy(SortedBy.wordLenght),
      ],
      selectedButtons: [
        GetDataCubit.get(context).sortedBy == SortedBy.time,
        GetDataCubit.get(context).sortedBy == SortedBy.wordLenght,
      ],
    );
  }

  Widget getLanguageFilter(BuildContext context) {
    return _getButtonFilter(
      lables: ['Arabic', 'English', 'All'],
      onTaps: [
        () => GetDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.arabicWordsOnly),
        () => GetDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.englishWordsOnly),
        () => GetDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.allWords)
      ],
      selectedButtons: [
        GetDataCubit.get(context).languageFilter ==
            LanguageFilter.arabicWordsOnly,
        GetDataCubit.get(context).languageFilter ==
            LanguageFilter.englishWordsOnly,
        GetDataCubit.get(context).languageFilter == LanguageFilter.allWords,
      ],
    );
  }

  Widget _getButtonFilter({
    required List<String> lables,
    required List<VoidCallback> onTaps,
    required List<bool> selectedButtons,
  }) {
    return Row(
      children: [
        for (int i = 0; i < lables.length; i++)
          InkWell(
            onTap: onTaps[i],
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.white,
                  width: 2,
                ),
                color: selectedButtons[i]
                    ? ColorManager.white
                    : ColorManager.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  lables[i],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: selectedButtons[i]
                        ? ColorManager.black
                        : ColorManager.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Text getText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: ColorManager.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
