import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_wallpaper/models/wallpaper/wallpaper_model.dart';
import 'package:get_wallpaper/services/api_service.dart';

part 'detail_wallpaper_cubit.freezed.dart';
part 'detail_wallpaper_state.dart';

class DetailWallpaperCubit extends Cubit<DetailWallpaperState> {
  DetailWallpaperCubit() : super(const DetailWallpaperState.initial());

  void getWallpaperDetail(int id) async {
    try {
      emit(const DetailWallpaperState.loading());
      final wallpaper = await ApiService().detailWallpaper(id);
      emit(DetailWallpaperState.loaded(wallpaper));
    } catch (e) {
      emit(DetailWallpaperState.error(e.toString()));
    }
  }
}
