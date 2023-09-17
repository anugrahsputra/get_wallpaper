import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'categorized_wallpaper_cubit.freezed.dart';
part 'categorized_wallpaper_state.dart';

class CategorizedWallpaperCubit extends Cubit<CategorizedWallpaperState> {
  final GetCategorizedWallpaper categorizedRepo;

  CategorizedWallpaperCubit(this.categorizedRepo)
      : super(const CategorizedWallpaperState.initial());

  void categoryWallpaper(String category) async {
    emit(const CategorizedWallpaperState.loading());
    final wallpaper = await categorizedRepo.call(category);
    wallpaper.fold(
      (failure) => emit(CategorizedWallpaperState.error(failure.message)),
      (wallpaperList) => emit(CategorizedWallpaperState.loaded(wallpaperList)),
    );
  }
}
