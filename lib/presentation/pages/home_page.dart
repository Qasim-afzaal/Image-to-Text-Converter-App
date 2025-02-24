import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_to_text_convertor/presentation/bloc/text_recognition_bloc.dart';
import 'package:image_to_text_convertor/presentation/widgets/image_view.dart';
import 'package:image_to_text_convertor/presentation/widgets/text_result.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  Future<void> _requestPermission(BuildContext context) async {
    PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {

      context.read<TextRecognitionBloc>().add(PickImageEvent());
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied to access photos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text('Text Recognizer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _requestPermission(context), // Request permission before picking image
                  child: const Text('Pick Image'),
                ),
                ElevatedButton(
                  onPressed: () => context
                      .read<TextRecognitionBloc>()
                      .add(RecognizeTextEvent()),
                  child: const Text('Recognize Text'),
                ),
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
