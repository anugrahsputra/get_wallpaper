import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_source.freezed.dart';

@freezed
class ImageSource with _$ImageSource {
  const factory ImageSource({
    required String original,
    required String large2x,
    required String large,
    required String medium,
    required String small,
    required String portrait,
    required String landscape,
    required String tiny,
  }) = _ImageSource;
}
