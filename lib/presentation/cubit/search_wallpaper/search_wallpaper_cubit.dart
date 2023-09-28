import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

part 'search_wallpaper_cubit.freezed.dart';
part 'search_wallpaper_state.dart';

class SearchWallpaperCubit extends Cubit<SearchWallpaperState> {
  int currentPage = 1;
  final GetSearchWallpaper _repository;
  SearchWallpaperCubit(this._repository)
      : super(const SearchWallpaperState.initial());

  void searchWallpaper(String query) async {
    emit(const SearchWallpaperState.loading());
    final wallpaper = await _repository.call(query);
    wallpaper.fold(
      (failure) => emit(SearchWallpaperState.error(failure.message)),
      (wallpaperList) => emit(SearchWallpaperState.loaded(wallpaperList)),
    );
  }

  void loadMore(String query) async {
    emit(const SearchWallpaperState.loading());
    final wallpaper = await _repository.loadMore(query, currentPage);
    currentPage++;
    final nextWallpaper = state.maybeWhen(
      loaded: (wallpapers) => wallpapers,
      orElse: () => [],
    );
    wallpaper.fold(
      (failure) => emit(SearchWallpaperState.error(failure.message)),
      (wallpaperList) {
        emit(SearchWallpaperState.loaded([...nextWallpaper, ...wallpaperList]));
      },
    );
  }

  void clearSearch() {
    emit(const SearchWallpaperState.initial());
  }
}
