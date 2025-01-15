import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_notes_app/core/errors/error_snackBar.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit_states.dart';
import 'package:vocabulary_notes_app/views/widgets/arabic_or_english_widget.dart';
import 'package:vocabulary_notes_app/views/widgets/done_button.dart';
import 'package:vocabulary_notes_app/views/widgets/text_form_feild.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog(
      {super.key,
      required this.isExample,
      required this.colorCode,
      required this.indexAtDatabase});
  final int colorCode;
  final int indexAtDatabase;
  final bool isExample;

  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OperationsOnDataCubit, OperationsOnDataCubitStates>(
      listener: (context, state) {
        if (state is OperationsOnDataCubitSuccessState) {
          Navigator.pop(context);
        } else if (state is OperationsOnDataCubitFailedState) {
          getSnackBar(context, state);
        }
      },
      builder: (context, state) {
        return Dialog(
          backgroundColor: Color(widget.colorCode),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                ArabicOrEnglishWidget(
                  colorCode: widget.colorCode,
                  isArabic: OperationsOnDataCubit.get(context).isArabic,
                ),
                TextFormFeild(
                  formKey: _formKey,
                  label: widget.isExample ? 'New Example' : 'New Similar Word',
                ),
                DoneButton(
                  colorCode: widget.colorCode,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isExample) {
                        OperationsOnDataCubit.get(context).addExample(
                          widget.indexAtDatabase,
                        );
                      } else {
                        OperationsOnDataCubit.get(context).addSimilarWord(
                          widget.indexAtDatabase,
                        );
                      }
                      GetDataCubit.get(context).getWords();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
