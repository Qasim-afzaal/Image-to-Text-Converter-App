import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_to_text_convertor/domain/usecases/recognize_text.dart';


import '../../domain/usecases/pick_image.dart';

part 'text_recognition_event.dart';
part 'text_recognition_state.dart';

class TextRecognitionBloc
    extends Bloc<TextRecognitionEvent, TextRecognitionState> {
  final PickImage pickImage;
  final RecognizeText recognizeText;

  TextRecognitionBloc({
    required this.pickImage,
    required this.recognizeText,
  }) : super(TextRecognitionInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<RecognizeTextEvent>(_onRecognizeText);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<TextRecognitionState> emit,
  ) async {
    emit(TextRecognitionLoading());
    try {
      final imagePath = await pickImage();
      emit(TextRecognitionLoaded(imagePath: imagePath));
    } catch (e) {
      emit(TextRecognitionError(e.toString()));
    }
  }

  Future<void> _onRecognizeText(
    RecognizeTextEvent event,
    Emitter<TextRecognitionState> emit,
  ) async {
    emit(TextRecognitionLoading());
    try {
      final text = await recognizeText(state.imagePath!);
      emit(TextRecognitionLoaded(
        imagePath: state.imagePath,
        recognizedText: text,
      ));
    } catch (e) {
      emit(TextRecognitionError(e.toString()));
    }
  }
}