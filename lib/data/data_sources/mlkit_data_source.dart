import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class MLKitDataSource {
  final TextRecognizer _textRecognizer = TextRecognizer();

  Future<String> recognizeText(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  void close() => _textRecognizer.close();
}