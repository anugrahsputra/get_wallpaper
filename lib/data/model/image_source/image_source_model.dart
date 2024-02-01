import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'image_source_model.freezed.dart';
part 'image_source_model.g.dart';

@freezed
class ImageSourceModel with _$ImageSourceModel {
  const factory ImageSourceModel({
    @JsonKey(name: 'original') @Default("") String original,
    @JsonKey(name: 'large2x') @Default("") String large2x,
    @JsonKey(name: 'large') @Default("") String large,
    @JsonKey(name: 'medium') @Default("") String medium,
    @JsonKey(name: 'small') @Default("") String small,
    @JsonKey(name: 'portrait') @Default("") String portrait,
    @JsonKey(name: 'landscape') @Default("") String landscape,
    @JsonKey(name: 'tiny') @Default("") String tiny,
  }) = _ImageSourceModel;

  factory ImageSourceModel.fromJson(Map<String, dynamic> json) =>
      _$ImageSourceModelFromJson(json);
}

extension ImageSourceModelX on ImageSourceModel {
  ImageSource toEntity() {
    return ImageSource(
      original: original,
      large2x: large2x,
      large: large,
      medium: medium,
      small: small,
      portrait: portrait,
      landscape: landscape,
      tiny: tiny,
    );
  }
}
