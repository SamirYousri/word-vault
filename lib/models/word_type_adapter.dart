import 'package:vocabulary_notes_app/models/word_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
      indexWordInDataBase: reader.readInt(),
      colorCode: reader.readInt(),
      wordText: reader.readString(),
      isArabic: reader.readBool(),
      arabicExamples: reader.readStringList(),
      englisExamples: reader.readStringList(),
      arabicSimilarWords: reader.readStringList(),
      englishSimilarWords: reader.readStringList(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeInt(obj.indexWordInDataBase);
    writer.writeInt(obj.colorCode);
    writer.writeString(obj.wordText);
    writer.writeBool(obj.isArabic);
    writer.writeStringList(obj.arabicExamples);
    writer.writeStringList(obj.englisExamples);
    writer.writeStringList(obj.arabicSimilarWords);
    writer.writeStringList(obj.englishSimilarWords);
  }
}
