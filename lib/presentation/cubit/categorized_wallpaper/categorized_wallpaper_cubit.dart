import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/model.dart';
import '../../../data/repository/repository.dart';

part 'categorized_wallpaper_cubit.freezed.dart';
part 'categorized_wallpaper_state.dart';

class CategorizedWallpaperCubit extends Cubit<CategorizedWallpaperState> {
  final CategorizedRepository categorizedRepo;

  CategorizedWallpaperCubit(this.categorizedRepo)
      : super(const CategorizedWallpaperState.initial());

  void categoryWallpaper(String category) async {
    try {
      emit(const CategorizedWallpaperState.loading());
      final wallpaper = await categorizedRepo.categorizedWallpaper(category);
      emit(CategorizedWallpaperState.loaded(wallpaper));
    } catch (e) {
      emit(CategorizedWallpaperState.error(e.toString()));
    }
  }
}
