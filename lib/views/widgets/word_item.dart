import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit.dart';
import 'package:vocabulary_notes_app/models/word_model.dart';
import 'package:vocabulary_notes_app/views/details_screen.dart';

class WordItem extends StatelessWidget {
  const WordItem({super.key, required this.wordModel});
  final WordModel wordModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                wordModel: wordModel,
              ),
            )).then((value) async {
          Future.delayed(const Duration(seconds: 1)).then((value) {
            GetDataCubit.get(context).getWords();
          });
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(wordModel.colorCode),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            wordModel.wordText,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}
