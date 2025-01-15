abstract class OperationsOnDataCubitStates {}

class OperationsOnDataCubitInitailState extends OperationsOnDataCubitStates {}

class OperationsOnDataCubitLoadingState extends OperationsOnDataCubitStates {}

class OperationsOnDataCubitSuccessState extends OperationsOnDataCubitStates {}

class OperationsOnDataCubitFailedState extends OperationsOnDataCubitStates {
  final String errMessage;
  OperationsOnDataCubitFailedState({required this.errMessage});
}
