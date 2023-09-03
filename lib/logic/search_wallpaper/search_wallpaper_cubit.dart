import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_wallpaper/models/wallpaper/wallpaper_model.dart';
import 'package:get_wallpaper/services/api_service.dart';

part 'search_wallpaper_cubit.freezed.dart';
part 'search_wallpaper_state.dart';

class SearchWallpaperCubit extends Cubit<SearchWallpaperState> {
  SearchWallpaperCubit() : super(const SearchWallpaperState.initial());

  void searchWallpaper(String query) async {
    try {
      emit(const SearchWallpaperState.loading());
      final wallpaper = await ApiService().searchWallpaper(query);
      log(wallpaper.toString());
      emit(SearchWallpaperState.loaded(wallpaper));
    } catch (e) {
      emit(SearchWallpaperState.error(e.toString()));
    }
  }

  void clearSearch() {
    emit(const SearchWallpaperState.initial());
  }
}
