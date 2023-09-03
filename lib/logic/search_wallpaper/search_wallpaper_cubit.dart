import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_wallpaper/models/wallpaper/wallpaper_model.dart';
import 'package:get_wallpaper/services/api_service.dart';

part 'search_wallpaper_cubit.freezed.dart';
part 'search_wallpaper_state.dart';

class SearchWallpaperCubit extends Cubit<SearchWallpaperState> {
  int currentPage = 1;
  SearchWallpaperCubit() : super(const SearchWallpaperState.initial());

  void searchWallpaper(String query) async {
    try {
      emit(const SearchWallpaperState.loading());
      final wallpaper = await ApiService().searchWallpaper(query);
      emit(SearchWallpaperState.loaded(wallpaper));
    } catch (e) {
      emit(SearchWallpaperState.error(e.toString()));
    }
  }

  void loadMore(String query) async {
    try {
      final wallpaper =
          await ApiService().searchWallpaper(query, page: currentPage);
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
