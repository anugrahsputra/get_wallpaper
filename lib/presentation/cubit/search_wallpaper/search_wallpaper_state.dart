part of 'search_wallpaper_cubit.dart';

@freezed
class SearchWallpaperState with _$SearchWallpaperState {
  const factory SearchWallpaperState.initial() = _Initial;
  const factory SearchWallpaperState.loading() = _Loading;
  const factory SearchWallpaperState.loaded(List<WallpaperModel> wallpapers) =
      _Loaded;
  const factory SearchWallpaperState.error(String message) = _Error;
}
