import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

part 'detail_wallpaper_cubit.freezed.dart';
part 'detail_wallpaper_state.dart';

class DetailWallpaperCubit extends Cubit<DetailWallpaperState> {
  final GetDetailWallpaper _repository;

  DetailWallpaperCubit(this._repository)
      : super(const DetailWallpaperState.initial());

  void getWallpaperDetail(int id) async {
    emit(const DetailWallpaperState.loading());
    final wallpaper = await _repository.execute(id);
    wallpaper.fold(
        (failure) => emit(DetailWallpaperState.error(failure.message)),
        (success) => emit(DetailWallpaperState.loaded(success)));
  }
}
