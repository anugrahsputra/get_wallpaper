import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/model.dart';
import '../../../data/repository/repository.dart';

part 'list_wallpaper_cubit.freezed.dart';
part 'list_wallpaper_state.dart';

class ListWallpaperCubit extends Cubit<ListWallpaperState> {
  final ListWallpaperRepository listWallpaperRepo;

  ListWallpaperCubit(this.listWallpaperRepo)
      : super(const ListWallpaperState.initial()) {
    getWallpaper();
  }

  void getWallpaper() async {
    try {
      emit(const ListWallpaperState.loading());
      final wallpaper = await listWallpaperRepo.listWallpaper();
      emit(ListWallpaperState.loaded(wallpaper));
    } catch (e) {
      emit(ListWallpaperState.error(e.toString()));
    }
  }

  // void loadMore() async {
  //   _isLoading = true;
  //   try {
  //     final wallpaper = await ApiService().listWallpaper(page: _currentPage);
  //     _currentPage++;
  //     final currentWallpaper = state.maybeWhen(
  //       loaded: (wallpapers) => wallpapers,
  //       orElse: () => [],
  //     );
  //     emit(ListWallpaperState.loaded([...currentWallpaper, ...wallpaper]));
  //   } catch (e) {
  //     emit(ListWallpaperState.error(e.toString()));
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  // bool get isLoading => _isLoading;
}
