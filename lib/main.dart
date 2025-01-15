import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabulary_notes_app/core/styles/theme_manager.dart';
import 'package:vocabulary_notes_app/core/hive_constants.dart';
import 'package:vocabulary_notes_app/manager/get_data_cubit/get_data_cubit.dart';
import 'package:vocabulary_notes_app/manager/operations_on_data_cubit/operations_on_data_cubit.dart';
import 'package:vocabulary_notes_app/models/word_type_adapter.dart';
import 'package:vocabulary_notes_app/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  await Hive.openBox(HiveConstants.wordsBox);
  runApp(const VocabularyNotes());
}

class VocabularyNotes extends StatelessWidget {
  const VocabularyNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetDataCubit()..getWords(),
        ),
        BlocProvider(
          create: (context) => OperationsOnDataCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeManager.getAppTheme(),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
