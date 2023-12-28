part of 'set_wallpaper_bloc.dart';

@freezed
class SetWallpaperState with _$SetWallpaperState {
  const factory SetWallpaperState.wallpaperInitial() = WallpaperInitial;
  const factory SetWallpaperState.wallpaperLoading() = WallpaperLoading;
  const factory SetWallpaperState.wallpaperHome(String result) = WallpaperHome;
  const factory SetWallpaperState.wallpaperLock(String result) = WallpaperLock;
  const factory SetWallpaperState.wallpaperBoth(String result) = WallpaperBoth;
  const factory SetWallpaperState.wallpaperError(String message) =
      WallpaperError;
}
