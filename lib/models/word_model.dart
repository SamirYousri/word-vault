class WordModel {
  final int indexWordInDataBase;
  final int colorCode;
  final String wordText;
  final bool isArabic;
  final List<String> arabicSimilarWords;
  final List<String> englishSimilarWords;
  final List<String> arabicExamples;
  final List<String> englisExamples;

  const WordModel({
    required this.indexWordInDataBase,
    required this.colorCode,
    required this.wordText,
    required this.isArabic,
    this.arabicSimilarWords = const [],
    this.englishSimilarWords = const [],
    this.arabicExamples = const [],
    this.englisExamples = const [],
  });

  WordModel addSimilarWord(bool isArabicSimilarWords, String newSimilarWord) {
    List<String> listNewSimilarWords =
        _initializeSimilarWords(isArabicSimilarWords);
    listNewSimilarWords.add(newSimilarWord);
    return _getnewSimilarWord(isArabicSimilarWords, listNewSimilarWords);
  }

  WordModel deleteSimilarWord(
      bool isArabicSimilarWords, int indexAtSimilarWoed) {
    List<String> listNewSimilarWords =
        _initializeSimilarWords(isArabicSimilarWords);
    listNewSimilarWords.removeAt(indexAtSimilarWoed);
    return _getnewSimilarWord(isArabicSimilarWords, listNewSimilarWords);
  }

  WordModel addExample(bool isArabicExample, String newExample) {
    List<String> addExamples = initialExample(isArabicExample);
    addExamples.add(newExample);
    return getExample(isArabicExample, addExamples);
  }

  WordModel deleteExample(bool isArabicExample, int indexAtExample) {
    List<String> addExamples = initialExample(isArabicExample);
    addExamples.removeAt(indexAtExample);
    return getExample(isArabicExample, addExamples);
  }

  WordModel decrementIndexAtDataBase() {
    return WordModel(
      indexWordInDataBase: indexWordInDataBase - 1,
      colorCode: colorCode,
      wordText: wordText,
      isArabic: isArabic,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
      arabicExamples: arabicExamples,
      englisExamples: englisExamples,
    );
  }

  List<String> initialExample(
    bool isArabicExample,
  ) {
    if (isArabicExample) {
      return List.from(arabicExamples);
    } else {
      return List.from(englisExamples);
    }
  }

  WordModel getExample(bool isArabicExample, List<String> addExamples) {
    return WordModel(
      indexWordInDataBase: indexWordInDataBase,
      colorCode: colorCode,
      wordText: wordText,
      isArabic: isArabic,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
      arabicExamples: isArabicExample ? addExamples : arabicExamples,
      englisExamples: !isArabicExample ? addExamples : englisExamples,
    );
  }

  List<String> _initializeSimilarWords(bool isArabicSimilarWords) {
    if (isArabicSimilarWords) {
      return List.from(arabicSimilarWords);
    } else {
      return List.from(englishSimilarWords);
    }
  }

  WordModel _getnewSimilarWord(
      bool isArabicSimilarWords, List<String> listNewSimilarWords) {
    return WordModel(
      indexWordInDataBase: indexWordInDataBase,
      colorCode: colorCode,
      wordText: wordText,
      isArabic: isArabic,
      arabicSimilarWords:
          isArabicSimilarWords ? listNewSimilarWords : arabicSimilarWords,
      englishSimilarWords:
          !isArabicSimilarWords ? listNewSimilarWords : englishSimilarWords,
      arabicExamples: arabicExamples,
      englisExamples: englisExamples,
    );
  }
}
