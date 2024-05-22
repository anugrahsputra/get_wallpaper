part of 'search_wallpaper_bloc.dart';

@freezed
class SearchState with _$SearchState {
  factory SearchState.initial() = Initial;
  factory SearchState.loading() = Loading;
  factory SearchState.loaded(List<Wallpaper> wallpapers) = Loaded;
  factory SearchState.error(ErrorMessage message) = Error;
}
