import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

part 'detail_bloc.freezed.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetailWallpaper repository;
  DetailBloc({required this.repository}) : super(const DetailInitial()) {
    on<Details>((event, emit) async {
      final id = event.id;
      emit(const DetailLoading());
      final result = await repository.execute(id);
      result.fold(
        (failure) => emit(DetailError(failure.message)),
        (wallpaper) => emit(DetailLoaded(wallpaper)),
      );
    });
  }
}
