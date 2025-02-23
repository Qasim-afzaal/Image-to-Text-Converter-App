abstract class TextRecognitionRepository {
  Future<String?> pickImage();
  Future<String> recognizeText(String imagePath);
}