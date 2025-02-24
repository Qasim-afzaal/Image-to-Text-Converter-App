import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_to_text_convertor/presentation/bloc/text_recognition_bloc.dart';

class TextResult extends StatelessWidget {
  const TextResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: BlocBuilder<TextRecognitionBloc, TextRecognitionState>(
        builder: (context, state) {
          if (state is TextRecognitionLoaded && state.recognizedText != null) {
            return SingleChildScrollView(
              child: Text(
                state.recognizedText!,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }
          return const Center(
            child: Text('Recognized text will appear here...'),
          );
        },
      ),
    );
  }
}