import 'package:image_to_text_convertor/domain/repositories/text_recognition_repository.dart';

class PickImage {
  final TextRecognitionRepository repository;

  PickImage(this.repository);

  Future<String?> call() async => await repository.pickImage();
}