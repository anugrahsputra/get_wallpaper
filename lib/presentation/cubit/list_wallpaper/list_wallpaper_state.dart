part of 'list_wallpaper_cubit.dart';

@freezed
class ListWallpaperState with _$ListWallpaperState {
  const factory ListWallpaperState.initial() = _Initial;
  const factory ListWallpaperState.loading() = _Loading;
  const factory ListWallpaperState.loaded(List<Wallpaper> wallpapers) = _Loaded;
  const factory ListWallpaperState.error(String message) = _Error;
}
