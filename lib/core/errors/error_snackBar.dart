// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit_states.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> getSnackBar(
    BuildContext context, OperationsOnDataCubitFailedState state) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(state.errMessage),
      duration: Duration(seconds: 2),
    ),
  );
}
