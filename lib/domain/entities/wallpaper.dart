import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain.dart';

part 'wallpaper.freezed.dart';

@freezed
class Wallpaper with _$Wallpaper {
  const factory Wallpaper({
    required int id,
    required int width,
    required int height,
    required String url,
    required String photographer,
    required String photographerUrl,
    required int photographerId,
    required String avgColor,
    required ImageSource src,
    required bool liked,
    required String alt,
  }) = _Wallpaper;
}
