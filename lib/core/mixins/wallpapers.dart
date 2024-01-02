import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_wallpaper/presentation/presentation.dart';

mixin Wallpapers {
  void getCuratedWallpaper(BuildContext context, int page) {
    context.read<WallpapersBloc>().add(Curated(page));
  }

  void getCategoryWallpaper(BuildContext context, String category, int page) {
    context.read<WallpapersBloc>().add(Category(category, page));
  }

  void submit(BuildContext context, String query, int page) {
    context.read<SearchBloc>().add(SearchQuery(query, page));
  }

  void clear(BuildContext context) {
    context.read<SearchBloc>().add(Started());
  }

  void searchLoadMore(BuildContext context, String query, int page) {
    context.read<SearchBloc>().add(More(query, page));
  }

  void wallpaperLoadMore(BuildContext context, String category, int page) {
    context.read<WallpapersBloc>().add(LoadMore(category, page));
  }

  void getDetailWallpaper(BuildContext context, int id) {
    context.read<DetailBloc>().add(Details(id));
  }
}
