import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_to_text_convertor/presentation/bloc/text_recognition_bloc.dart';
import 'package:image_to_text_convertor/presentation/widgets/image_view.dart';
import 'package:image_to_text_convertor/presentation/widgets/text_result.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Recognizer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.read<TextRecognitionBloc>().add(PickImageEvent()),
                  child: const Text('Pick Image')),
                ElevatedButton(
                  onPressed: () => context
                      .read<TextRecognitionBloc>()
                      .add(RecognizeTextEvent()),
                  child: const Text('Recognize Text')),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<TextRecognitionBloc, TextRecognitionState>(
              builder: (context, state) {
                if (state is TextRecognitionLoaded && state.imagePath != null) {
                  return ImageView(imagePath: state.imagePath!);
                }
                return const Placeholder();
              },
            ),
            const SizedBox(height: 20),
            const Expanded(child: TextResult()),
          ],
        ),
      ),
    );
  }
}