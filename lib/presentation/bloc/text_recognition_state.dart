part of 'text_recognition_bloc.dart';


sealed class TextRecognitionState {
  final String? imagePath;
  final String? recognizedText;

  const TextRecognitionState({this.imagePath, this.recognizedText});
}

final class TextRecognitionInitial extends TextRecognitionState {}

final class TextRecognitionLoading extends TextRecognitionState {}

final class TextRecognitionLoaded extends TextRecognitionState {
  const TextRecognitionLoaded({super.imagePath, super.recognizedText});
}

final class TextRecognitionError extends TextRecognitionState {
  final String message;

  const TextRecognitionError(this.message);
}