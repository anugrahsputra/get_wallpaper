import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

part 'wallpapers_bloc.freezed.dart';
part 'wallpapers_event.dart';
part 'wallpapers_state.dart';

class WallpapersBloc extends Bloc<WallpapersEvent, WallpapersState> {
  final GetListWallpaper getListRepo;
  final GetCategorizedWallpaper categorizedRepo;

  WallpapersBloc({
    required this.getListRepo,
    required this.categorizedRepo,
  }) : super(const Initial()) {
    on<Curated>(_fetchCurated);
    on<Category>(_fetchCategory);
    on<LoadMore>(_loadMore);
  }

  void _fetchCurated(
    Curated event,
    Emitter<WallpapersState> emit,
  ) async {
    int page = event.page;
    emit(const Loading());
    final result = await getListRepo.call(page);
    result.fold(
      (fail) => emit(Error(fail.message)),
      (success) => emit(CuratedLoaded(success)),
    );
  }

  void _fetchCategory(
    Category event,
    Emitter<WallpapersState> emit,
  ) async {
    int page = event.page;
    String category = event.category;
    emit(const Loading());
    final result = await categorizedRepo.call(category, page);
    result.fold(
      (fail) => emit(Error(fail.message)),
      (success) => emit(CategoryLoaded(success)),
    );
  }

  void _loadMore(
    LoadMore event,
    Emitter<WallpapersState> emit,
  ) async {
    if (state is CuratedLoaded) {
      int page = event.page;
      final result = await getListRepo.call(page);
      result.fold(
        (fail) => emit(Error(fail.message)),
        (success) {
          final currentState = state as CuratedLoaded;
          List<Wallpaper> updatedWallpapers = currentState.wallpaper + success;
          emit(CuratedLoaded(updatedWallpapers));
        },
      );
    }
    if (state is CategoryLoaded) {
      String category = event.category;
      int page = event.page;

      final result = await categorizedRepo.call(category, page);
      result.fold(
        (fail) => emit(Error(fail.message)),
        (success) {
          final currentState = state as CategoryLoaded;
          List<Wallpaper> updatedWallpapers = currentState.wallpaper + success;
          emit(CategoryLoaded(updatedWallpapers));
        },
      );
    }
  }
}
