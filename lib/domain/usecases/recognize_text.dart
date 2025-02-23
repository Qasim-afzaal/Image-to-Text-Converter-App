import 'package:image_to_text_convertor/domain/repositories/text_recognition_repository.dart';

class RecognizeText {
  final TextRecognitionRepository repository;

  RecognizeText(this.repository);

  Future<String> call(String imagePath) async =>
      await repository.recognizeText(imagePath);
}