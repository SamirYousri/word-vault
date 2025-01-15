import 'package:vocabulary_notes_app/models/word_model.dart';

abstract class GetDataCubitStates {}

class GetDataCubitInitailState extends GetDataCubitStates {}

class GetDataCubitLoadingState extends GetDataCubitStates {}

class GetDataCubitSuccessState extends GetDataCubitStates {
  final List<WordModel> words;
  GetDataCubitSuccessState({required this.words});
}

class GetDataCubitFailedState extends GetDataCubitStates {
  final String errMessage;
  GetDataCubitFailedState({required this.errMessage});
}
