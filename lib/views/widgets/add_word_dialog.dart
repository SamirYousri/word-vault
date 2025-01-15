import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_notes_app/core/errors/error_snackBar.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit_states.dart';
import 'package:vocabulary_notes_app/views/widgets/arabic_or_english_widget.dart';
import 'package:vocabulary_notes_app/views/widgets/colors_widget.dart';
import 'package:vocabulary_notes_app/views/widgets/done_button.dart';
import 'package:vocabulary_notes_app/views/widgets/text_form_feild.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey();

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
        return BlocBuilder<OperationsOnDataCubit, OperationsOnDataCubitStates>(
          builder: (context, state) {
            return Dialog(
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(OperationsOnDataCubit.get(context).colorCode),
                ),
                padding: EdgeInsets.all(12),
                duration: Duration(milliseconds: 800),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ArabicOrEnglishWidget(
                        colorCode: OperationsOnDataCubit.get(context).colorCode,
                        isArabic: OperationsOnDataCubit.get(context).isArabic,
                      ),
                      ColorsWidget(
                          activeColorCode:
                              OperationsOnDataCubit.get(context).colorCode),
                      TextFormFeild(
                        label: 'add new word',
                        formKey: formKey,
                      ),
                      DoneButton(
                        colorCode: OperationsOnDataCubit.get(context).colorCode,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            OperationsOnDataCubit.get(context).addWord();
                            GetDataCubit.get(context).getWords();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
