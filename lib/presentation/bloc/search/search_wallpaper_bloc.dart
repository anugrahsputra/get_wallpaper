import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';

part 'search_wallpaper_bloc.freezed.dart';
part 'search_wallpaper_event.dart';
part 'search_wallpaper_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchWallpaper repository;
  SearchBloc({required this.repository}) : super(Initial()) {
    on<Started>(_clearSearch);
    on<SearchQuery>(
      _searchWallpaper,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void _searchWallpaper(
    SearchQuery event,
    Emitter<SearchState> emit,
  ) async {
    int page = event.page;
    String query = event.query;

    emit(Loading());
    final result = await repository.call(query, page);
    result.fold((fail) {
      emit(Error(fail.message));
    }, (success) {
      emit(Loaded(success));
    });
  }

  void _clearSearch(Started event, Emitter<SearchState> emit) {
    emit(Initial());
  }
}
