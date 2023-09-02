part of 'detail_wallpaper_cubit.dart';

@freezed
class DetailWallpaperState with _$DetailWallpaperState {
  const factory DetailWallpaperState.initial() = _Initial;
  const factory DetailWallpaperState.loading() = _loading;
  const factory DetailWallpaperState.loaded(WallpaperModel wallpaper) = _Loaded;
  const factory DetailWallpaperState.error(String message) = _Error;
}
