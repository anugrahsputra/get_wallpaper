import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_wallpaper/models/wallpaper/wallpaper_model.dart';
import 'package:get_wallpaper/services/api_service.dart';

part 'categorized_wallpaper_cubit.freezed.dart';
part 'categorized_wallpaper_state.dart';

class CategorizedWallpaperCubit extends Cubit<CategorizedWallpaperState> {
  CategorizedWallpaperCubit()
      : super(const CategorizedWallpaperState.initial());

  void categoryWallpaper(String category) async {
    try {
      emit(const CategorizedWallpaperState.loading());
      final wallpaper = await ApiService().categorizedWallpaper(category);
      emit(CategorizedWallpaperState.loaded(wallpaper));
    } catch (e) {
      emit(CategorizedWallpaperState.error(e.toString()));
    }
  }
}
