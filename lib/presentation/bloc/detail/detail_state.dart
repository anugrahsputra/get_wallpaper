part of 'detail_bloc.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState.initial() = DetailInitial;
  const factory DetailState.loading() = DetailLoading;
  const factory DetailState.loaded(Wallpaper wallpaper) = DetailLoaded;
  const factory DetailState.error(ErrorMessage message) = DetailError;
}
