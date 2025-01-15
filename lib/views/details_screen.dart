import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_notes_app/core/errors/exption_widget.dart';
import 'package:vocabulary_notes_app/core/widget/custom_cercular_progress.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit_states.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit.dart';
import 'package:vocabulary_notes_app/models/word_model.dart';
import 'package:vocabulary_notes_app/views/widgets/update_word_button.dart';
import 'package:vocabulary_notes_app/views/widgets/update_word_dialog.dart';
import 'package:vocabulary_notes_app/views/widgets/word_info.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late WordModel _wordModel;

  @override
  void initState() {
    super.initState();
    _wordModel = widget.wordModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: BlocBuilder<GetDataCubit, GetDataCubitStates>(
        builder: (context, state) {
          if (state is GetDataCubitSuccessState) {
            int index = state.words.indexWhere(
              (element) =>
                  element.indexWordInDataBase == _wordModel.indexWordInDataBase,
            );
            _wordModel = state.words[index];
            return _getBody(context);
          }
          if (state is GetDataCubitFailedState) {
            return ExptionWidget(
              iconData: Icons.error,
              text: state.errMessage,
            );
          }
          return getLoading();
        },
      ),
    );
  }

  Padding _getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
        children: [
          _getText('Word'),
          SizedBox(
            height: 10,
          ),
          WordInfo(
            text: _wordModel.wordText,
            color: Color(_wordModel.colorCode),
            isArabic: _wordModel.isArabic,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              _getText('Similar Words'),
              Spacer(),
              UpdateWordButton(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => UpdateWordDialog(
                    isExample: false,
                    colorCode: _wordModel.colorCode,
                    indexAtDatabase: _wordModel.indexWordInDataBase,
                  ),
                ),
                color: Color(_wordModel.colorCode),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < _wordModel.arabicSimilarWords.length; i++)
            WordInfo(
              text: _wordModel.arabicSimilarWords[i],
              color: Color(_wordModel.colorCode),
              isArabic: true,
              onTap: () => _deleteArabicSimilarWord(i),
            ),
          for (int i = 0; i < _wordModel.englishSimilarWords.length; i++)
            WordInfo(
              text: _wordModel.englishSimilarWords[i],
              color: Color(_wordModel.colorCode),
              isArabic: false,
              onTap: () => _deleteEnglishSimilarWord(i),
            ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              _getText('Examples'),
              Spacer(),
              UpdateWordButton(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => UpdateWordDialog(
                    isExample: true,
                    colorCode: _wordModel.colorCode,
                    indexAtDatabase: _wordModel.indexWordInDataBase,
                  ),
                ),
                color: Color(_wordModel.colorCode),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < _wordModel.arabicExamples.length; i++)
            WordInfo(
              text: _wordModel.arabicExamples[i],
              color: Color(_wordModel.colorCode),
              isArabic: true,
              onTap: () => _deleteArabicExample(i),
            ),
          for (int i = 0; i < _wordModel.englisExamples.length; i++)
            WordInfo(
              text: _wordModel.englisExamples[i],
              color: Color(_wordModel.colorCode),
              isArabic: false,
              onTap: () => _deleteEnglishExample(i),
            ),
        ],
      ),
    );
  }

  void _deleteEnglishExample(int index) {
    OperationsOnDataCubit.get(context)
        .deleteExample(_wordModel.indexWordInDataBase, false, index);

    GetDataCubit.get(context).getWords();
  }

  void _deleteArabicExample(int index) {
    OperationsOnDataCubit.get(context).deleteExample(
      _wordModel.indexWordInDataBase,
      true,
      index,
    );
    GetDataCubit.get(context).getWords();
  }

  void _deleteEnglishSimilarWord(int index) {
    OperationsOnDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexWordInDataBase,
      false,
      index,
    );
    GetDataCubit.get(context).getWords();
  }

  void _deleteArabicSimilarWord(int index) {
    OperationsOnDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexWordInDataBase,
      true,
      index,
    );
    GetDataCubit.get(context).getWords();
  }

  Text _getText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Color(_wordModel.colorCode),
          fontSize: 30,
          fontWeight: FontWeight.bold),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: Color(_wordModel.colorCode),
      title: Text(
        'Word Details',
        style: TextStyle(color: Color(_wordModel.colorCode)),
      ),
      actions: [
        IconButton(
          onPressed: () {
            OperationsOnDataCubit.get(context)
                .deleteWord(_wordModel.indexWordInDataBase);
            Navigator.pop(context);
          },
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
