part of 'text_recognition_bloc.dart';


sealed class TextRecognitionEvent {}

class PickImageEvent extends TextRecognitionEvent {}

class RecognizeTextEvent extends TextRecognitionEvent {}