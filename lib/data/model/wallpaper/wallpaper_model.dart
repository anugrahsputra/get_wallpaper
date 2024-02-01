import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';
import '../model.dart';

part 'wallpaper_model.freezed.dart';
part 'wallpaper_model.g.dart';

@freezed
class WallpaperModel with _$WallpaperModel {
  @JsonSerializable(explicitToJson: true)
  const factory WallpaperModel({
    @JsonKey(name: 'id') @Default(0) int id,
    @JsonKey(name: 'width') @Default(0) int width,
    @JsonKey(name: 'height') @Default(0) int height,
    @JsonKey(name: 'url') @Default("") String url,
    @JsonKey(name: 'photographer') @Default("") String photographer,
    @JsonKey(name: 'photographer_url') @Default("") String photographerUrl,
    @JsonKey(name: 'photographer_id') @Default(0) int photographerId,
    @JsonKey(name: 'avg_color') @Default("") String avgColor,
    @JsonKey(name: 'src') required ImageSourceModel src,
    required bool liked,
    required String alt,
  }) = _WallpaperModel;

  factory WallpaperModel.fromJson(Map<String, dynamic> json) =>
      _$WallpaperModelFromJson(json);
}

extension WallpaperModelX on WallpaperModel {
  Wallpaper toEntity() {
    return Wallpaper(
      id: id,
      width: width,
      height: height,
      url: url,
      photographer: photographer,
      photographerUrl: photographerUrl,
      photographerId: photographerId,
      avgColor: avgColor,
      src: src.toEntity(),
      liked: liked,
      alt: alt,
    );
  }
}
