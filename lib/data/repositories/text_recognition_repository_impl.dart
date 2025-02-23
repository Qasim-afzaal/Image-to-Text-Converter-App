import 'package:image_to_text_convertor/data/data_sources/local_data_source.dart';
import 'package:image_to_text_convertor/data/data_sources/mlkit_data_source.dart';
import 'package:image_to_text_convertor/domain/repositories/text_recognition_repository.dart';

class TextRecognitionRepositoryImpl implements TextRecognitionRepository {
  final LocalDataSource localDataSource;
  final MLKitDataSource mlKitDataSource;

  TextRecognitionRepositoryImpl({
    required this.localDataSource,
    required this.mlKitDataSource,
  });

  @override
  Future<String?> pickImage() => localDataSource.pickImageFromGallery();

  @override
  Future<String> recognizeText(String imagePath) =>
      mlKitDataSource.recognizeText(imagePath);
}