import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabulary_notes_app/core/hive_constants.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit_states.dart';
import 'package:vocabulary_notes_app/models/word_model.dart';

class GetDataCubit extends Cubit<GetDataCubitStates> {
  GetDataCubit() : super(GetDataCubitInitailState());
  static GetDataCubit get(context) => BlocProvider.of(context);

  final _box = Hive.box(HiveConstants.wordsBox);
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.descending;
  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
    getWords();
  }

  void updateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
    getWords();
  }

  void updateSortingType(SortingType sortingType) {
    this.sortingType = sortingType;
    getWords();
  }

  void getWords() {
    emit(GetDataCubitLoadingState());
    try {
      List<WordModel> listWordsToRetrn =
          List.from(_box.get(HiveConstants.wordsListKey, defaultValue: []))
              .cast<WordModel>();
      _removeUnwantedWords(listWordsToRetrn);
      _applySorting(listWordsToRetrn);

      emit(GetDataCubitSuccessState(words: listWordsToRetrn));
    } catch (e) {
      emit(GetDataCubitFailedState(errMessage: 'there was an error,try later'));
    }
  }

  void _removeUnwantedWords(List<WordModel> listWordsToRetrn) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (var i = 0; i < listWordsToRetrn.length; i++) {
      if ((languageFilter == LanguageFilter.arabicWordsOnly &&
              listWordsToRetrn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishWordsOnly &&
              listWordsToRetrn[i].isArabic == true)) {
        listWordsToRetrn.removeAt(i);
        i--;
      }
    }
  }

  void _applySorting(List<WordModel> listWordsToRetrn) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.descending) {
        return;
      } else {
        _reversedWords(listWordsToRetrn);
      }
    } else {
      listWordsToRetrn.sort(
        (WordModel a, WordModel b) =>
            a.wordText.length.compareTo(b.wordText.length),
      );
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reversedWords(listWordsToRetrn);
      }
    }
  }

  void _reversedWords(List<WordModel> listWordsToRetrn) {
    for (var i = 0; i < listWordsToRetrn.length / 2; i++) {
      var temp = listWordsToRetrn[i];
      listWordsToRetrn[i] = listWordsToRetrn[listWordsToRetrn.length - 1 - i];
      listWordsToRetrn[listWordsToRetrn.length - 1 - i] = temp;
    }
  }
}

enum LanguageFilter {
  arabicWordsOnly,
  englishWordsOnly,
  allWords,
}

enum SortedBy {
  time,
  wordLenght,
}

enum SortingType {
  ascending,
  descending,
}
