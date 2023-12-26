import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_wallpaper/presentation/presentation.dart';

mixin Wallpapers {
  void getCuratedWallpaper(BuildContext context) {
    context.read<WallpapersBloc>().add(const Curated());
  }

  void getCategoryWallpaper(BuildContext context, String category) {
    context.read<WallpapersBloc>().add(Category(category));
  }

  void submit(BuildContext context, String query, int page) {
    context.read<SearchBloc>().add(SearchQuery(query, page));
  }

  void clear(BuildContext context) {
    context.read<SearchBloc>().add(Started());
  }

  void getDetailWallpaper(BuildContext context, int id) {
    context.read<DetailBloc>().add(Details(id));
  }
}
