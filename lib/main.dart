import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_to_text_convertor/data/data_sources/local_data_source.dart';
import 'package:image_to_text_convertor/data/data_sources/mlkit_data_source.dart';
import 'package:image_to_text_convertor/data/repositories/text_recognition_repository_impl.dart';
import 'package:image_to_text_convertor/domain/usecases/pick_image.dart';
import 'package:image_to_text_convertor/domain/usecases/recognize_text.dart';
import 'package:image_to_text_convertor/presentation/bloc/text_recognition_bloc.dart';
import 'package:image_to_text_convertor/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TextRecognitionRepositoryImpl(
            localDataSource: LocalDataSource(),
            mlKitDataSource: MLKitDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TextRecognitionBloc(
              pickImage: PickImage(context.read<TextRecognitionRepositoryImpl>()),
              recognizeText: RecognizeText(context.read<TextRecognitionRepositoryImpl>()),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Text Recognizer',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const HomePage(),
        ),
      ),
    );
  }
}