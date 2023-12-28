part of 'set_wallpaper_bloc.dart';

@freezed
class SetWallpaperEvent with _$SetWallpaperEvent {
  const factory SetWallpaperEvent.setInitial() = SetInitial;
  const factory SetWallpaperEvent.setHome(String url) = SetHome;
  const factory SetWallpaperEvent.setLock(String url) = SetLock;
  const factory SetWallpaperEvent.setBoth(String url) = SetBoth;
}
