part of 'categorized_wallpaper_cubit.dart';

@freezed
class CategorizedWallpaperState with _$CategorizedWallpaperState {
  const factory CategorizedWallpaperState.initial() = _Initial;
  const factory CategorizedWallpaperState.loading() = _Loading;
  const factory CategorizedWallpaperState.loaded(
      List<WallpaperModel> wallpapers) = _Loaded;
  const factory CategorizedWallpaperState.error(String message) = _Error;
}
