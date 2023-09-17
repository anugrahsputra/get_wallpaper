import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'list_wallpaper_cubit.freezed.dart';
part 'list_wallpaper_state.dart';

class ListWallpaperCubit extends Cubit<ListWallpaperState> {
  final GetListWallpaper listWallpaperRepo;

  ListWallpaperCubit(this.listWallpaperRepo)
      : super(const ListWallpaperState.initial()) {
    getWallpaper();
  }

  void getWallpaper() async {
    emit(const ListWallpaperState.loading());
    final wallpaper = await listWallpaperRepo.call();
    wallpaper.fold(
      (failure) => emit(ListWallpaperState.error(failure.message)),
      (wallpaperList) => emit(ListWallpaperState.loaded(wallpaperList)),
    );
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
