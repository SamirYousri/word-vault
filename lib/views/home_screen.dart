import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/core/styles/color_manager.dart';
import 'package:vocabulary_notes_app/views/widgets/add_word_dialog.dart';
import 'package:vocabulary_notes_app/views/widgets/filter_dialog_button.dart';
import 'package:vocabulary_notes_app/views/widgets/language_filter_text.dart';
import 'package:vocabulary_notes_app/views/widgets/words_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      floatingActionButton: getFloatingActionButton(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 20,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LanguageFilterText(),
                FilterDialogButton(),
              ],
            ),
            Expanded(child: WordsGridView()),
          ],
        ),
      ),
    );
  }

  FloatingActionButton getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.white,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AddWordDialog(),
      ),
      child: Icon(
        Icons.add,
        size: 30,
        color: ColorManager.black,
      ),
    );
  }
}
