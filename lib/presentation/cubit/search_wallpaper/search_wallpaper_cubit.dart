import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/model.dart';
import '../../../data/repository/repository.dart';

part 'search_wallpaper_cubit.freezed.dart';
part 'search_wallpaper_state.dart';

class SearchWallpaperCubit extends Cubit<SearchWallpaperState> {
  int currentPage = 1;
  final SearchWallpaperRepository _repository;
  SearchWallpaperCubit(this._repository)
      : super(const SearchWallpaperState.initial());

  void searchWallpaper(String query) async {
    try {
      emit(const SearchWallpaperState.loading());
      final wallpaper = await _repository.searchWallpaper(query);
      emit(SearchWallpaperState.loaded(wallpaper));
    } catch (e) {
      emit(SearchWallpaperState.error(e.toString()));
    }
  }

  void loadMore(String query) async {
    try {
      final wallpaper = await _repository.loadMore(query, currentPage);
      currentPage++;
      final currentWallpaper = state.maybeWhen(
        loaded: (wallpapers) => wallpapers,
        orElse: () => [],
      );
      emit(SearchWallpaperState.loaded([...currentWallpaper, ...wallpaper]));
    } catch (e) {
      emit(SearchWallpaperState.error(e.toString()));
    }
  }

  void clearSearch() {
    emit(const SearchWallpaperState.initial());
  }
}
