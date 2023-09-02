import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_wallpaper/models/wallpaper/wallpaper_model.dart';
import 'package:get_wallpaper/services/api_service.dart';

part 'list_wallpaper_cubit.freezed.dart';
part 'list_wallpaper_state.dart';

class ListWallpaperCubit extends Cubit<ListWallpaperState> {
  int _currentPage = 1;

  bool _isLoading = false;
  ListWallpaperCubit() : super(const ListWallpaperState.initial()) {
    getWallpaper();
  }

  void getWallpaper() async {
    try {
      emit(const ListWallpaperState.loading());
      final wallpaper = await ApiService().listWallpaper();
      emit(ListWallpaperState.loaded(wallpaper));
    } catch (e) {
      emit(ListWallpaperState.error(e.toString()));
    }
  }

  void loadMore() async {
    _isLoading = true;
    try {
      final wallpaper = await ApiService().listWallpaper(page: _currentPage);
      _currentPage++;
      final currentWallpaper = state.maybeWhen(
        loaded: (wallpapers) => wallpapers,
        orElse: () => [],
      );
      emit(ListWallpaperState.loaded([...currentWallpaper, ...wallpaper]));
    } catch (e) {
      emit(ListWallpaperState.error(e.toString()));
    } finally {
      _isLoading = false;
    }
  }

  bool get isLoading => _isLoading;
}
