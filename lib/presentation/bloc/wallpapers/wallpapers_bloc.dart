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
  }

  void _fetchCurated(
    Curated event,
    Emitter<WallpapersState> emit,
  ) async {
    emit(const Loading());
    final result = await getListRepo.call();
    result.fold(
      (fail) => emit(Error(fail.message)),
      (success) => emit(CuratedLoaded(success)),
    );
  }

  void _fetchCategory(
    Category event,
    Emitter<WallpapersState> emit,
  ) async {
    String category = event.category;
    emit(const Loading());
    final result = await categorizedRepo.call(category);
    result.fold(
      (fail) => emit(Error(fail.message)),
      (success) => emit(CategoryLoaded(success)),
    );
  }
}
