part of 'wallpapers_bloc.dart';

@freezed
class WallpapersState with _$WallpapersState {
  const factory WallpapersState.initial() = Initial;
  const factory WallpapersState.loading() = Loading;
  const factory WallpapersState.curatedLoaded(List<Wallpaper> wallpaper) =
      CuratedLoaded;
  const factory WallpapersState.categoryLoaded(List<Wallpaper> wallpaper) =
      CategoryLoaded;
  const factory WallpapersState.error(ErrorMessage message) = Error;
}
