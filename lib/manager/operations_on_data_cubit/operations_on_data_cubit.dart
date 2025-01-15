import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabulary_notes_app/core/hive_constants.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit_states.dart';
import 'package:vocabulary_notes_app/models/word_model.dart';

class OperationsOnDataCubit extends Cubit<OperationsOnDataCubitStates> {
  OperationsOnDataCubit() : super(OperationsOnDataCubitInitailState());
  static OperationsOnDataCubit get(context) => BlocProvider.of(context);
  final box = Hive.box(HiveConstants.wordsBox);
  String wordText = '';
  int colorCode = 0XFF4A47A3;
  bool isArabic = true;

  void updateText(String text) {
    wordText = text;
  }

  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(OperationsOnDataCubitInitailState());
  }

  void updateColor(int color) {
    colorCode = color;
    emit(OperationsOnDataCubitInitailState());
  }

  void addWord() {
    _tryAndCatchInCubit(() {
      List<WordModel> words = _getWordsFromDataBase();
      words.add(WordModel(
          indexWordInDataBase: words.length,
          colorCode: colorCode,
          wordText: wordText,
          isArabic: isArabic));
      box.put(HiveConstants.wordsListKey, words);
    }, 'there was an add error');
  }

  void deleteWord(int indexWordInDataBase) {
    _tryAndCatchInCubit(() {
      List<WordModel> words = _getWordsFromDataBase();

      words.removeAt(indexWordInDataBase);
      for (var i = indexWordInDataBase; i < words.length; i++) {
        words[i] = words[i].decrementIndexAtDataBase();
      }

      box.put(HiveConstants.wordsListKey, words);
    }, 'there was an delete error');
  }

  void addSimilarWord(int indexWordInDataBase) {
    _tryAndCatchInCubit(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexWordInDataBase] =
          words[indexWordInDataBase].addSimilarWord(isArabic, wordText);
      box.put(HiveConstants.wordsListKey, words);
    }, 'there was an add similar word error');
  }

  void addExample(int indexWordInDataBase) {
    _tryAndCatchInCubit(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexWordInDataBase] =
          words[indexWordInDataBase].addExample(isArabic, wordText);
      box.put(HiveConstants.wordsListKey, words);
    }, 'there was an add example error');
  }

  void deleteSimilarWord(int indexWordInDataBase, bool isArabicSimilarWords,
      int indexAtSimilarWoed) {
    _tryAndCatchInCubit(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexWordInDataBase] = words[indexWordInDataBase]
          .deleteSimilarWord(isArabicSimilarWords, indexAtSimilarWoed);
      box.put(HiveConstants.wordsListKey, words);
    }, 'there was an add example error');
  }

  void deleteExample(
      int indexWordInDataBase, bool isArabicExample, int indexAtExample) {
    _tryAndCatchInCubit(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexWordInDataBase] = words[indexWordInDataBase]
          .deleteExample(isArabicExample, indexAtExample);
      box.put(HiveConstants.wordsListKey, words);
    }, 'there was an add example error');
  }

  void _tryAndCatchInCubit(VoidCallback methodToExcute, String errMessage) {
    emit(OperationsOnDataCubitLoadingState());
    try {
      methodToExcute.call();
      emit(OperationsOnDataCubitSuccessState());
    } catch (e) {
      emit(OperationsOnDataCubitFailedState(errMessage: errMessage));
    }
  }

  List<WordModel> _getWordsFromDataBase() =>
      List.from(box.get(HiveConstants.wordsListKey, defaultValue: []))
          .cast<WordModel>();
}
