import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/model.dart';
import '../../../data/repository/repository.dart';

part 'detail_wallpaper_cubit.freezed.dart';
part 'detail_wallpaper_state.dart';

class DetailWallpaperCubit extends Cubit<DetailWallpaperState> {
  final DetailWallpaperRepository _repository;

  DetailWallpaperCubit(this._repository)
      : super(const DetailWallpaperState.initial());

  void getWallpaperDetail(int id) async {
    try {
      emit(const DetailWallpaperState.loading());
      final wallpaper = await _repository.detailWallpaper(id);
      emit(DetailWallpaperState.loaded(wallpaper));
    } catch (e) {
      emit(DetailWallpaperState.error(e.toString()));
    }
  }
}
