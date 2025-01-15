import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_notes_app/core/errors/exption_widget.dart';
import 'package:vocabulary_notes_app/core/widget/custom_cercular_progress.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit_states.dart';
import 'package:vocabulary_notes_app/models/word_model.dart';
import 'package:vocabulary_notes_app/views/widgets/word_item.dart';

class WordsGridView extends StatelessWidget {
  const WordsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataCubit, GetDataCubitStates>(
      builder: (context, state) {
        if (state is GetDataCubitSuccessState) {
          if (state.words.isEmpty) {
            return _getEmptyWords();
          } else {
            return _getDateInGridView(state.words);
          }
        } else if (state is GetDataCubitFailedState) {
          return _getFailed(state);
        } else {
          return getLoading();
        }
      },
    );
  }

  ExptionWidget _getFailed(GetDataCubitFailedState state) {
    return ExptionWidget(
      text: state.errMessage,
      iconData: Icons.error,
    );
  }

  ExptionWidget _getEmptyWords() {
    return ExptionWidget(
      text: 'Empty Words List, Add a New Word',
      iconData: Icons.list,
    );
  }

  GridView _getDateInGridView(List<WordModel> words) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2 / 1.5,
      ),
      itemBuilder: (context, index) => WordItem(
        wordModel: words[index],
      ),
      itemCount: words.length,
    );
  }
}
