import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/core.dart';

part 'set_wallpaper_bloc.freezed.dart';
part 'set_wallpaper_event.dart';
part 'set_wallpaper_state.dart';

class SetWallpaperBloc extends Bloc<SetWallpaperEvent, SetWallpaperState> {
  final WallpaperHandler wallpaperHandler;

  SetWallpaperBloc({required this.wallpaperHandler})
      : super(const WallpaperInitial()) {
    on<SetHome>(_setAsHome);
    on<SetLock>(_setAsLock);
    on<SetBoth>(_setAsBoth);
  }

  void _setAsHome(
    SetHome event,
    Emitter<SetWallpaperState> emit,
  ) async {
    String url = event.url;
    emit(const WallpaperLoading());
    try {
      final result = await wallpaperHandler.setAsWallpaper(
          url, AsyncWallpaper.HOME_SCREEN);
      emit(WallpaperHome(result));
    } catch (e) {
      emit(WallpaperError(e.toString()));
    }
  }

  void _setAsLock(
    SetLock event,
    Emitter<SetWallpaperState> emit,
  ) async {
    String url = event.url;
    emit(const WallpaperLoading());
    try {
      final result = await wallpaperHandler.setAsWallpaper(
          url, AsyncWallpaper.LOCK_SCREEN);
      emit(WallpaperLock(result));
    } catch (e) {
      emit(WallpaperError(e.toString()));
    }
  }

  void _setAsBoth(
    SetBoth event,
    Emitter<SetWallpaperState> emit,
  ) async {
    String url = event.url;
    emit(const WallpaperLoading());
    try {
      final result = await wallpaperHandler.setAsWallpaper(
          url, AsyncWallpaper.BOTH_SCREENS);
      emit(WallpaperBoth(result));
    } catch (e) {
      emit(WallpaperError(e.toString()));
    }
  }
}
