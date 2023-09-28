import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

class GetSearchWallpaper {
  final WallpaperRepository repository;

  GetSearchWallpaper(this.repository);

  Future<Either<Failure, List<Wallpaper>>> call(String query) async {
    return await repository.searchWallpaper(query);
  }

  Future<Either<Failure, List<Wallpaper>>> loadMore(
      String query, int page) async {
    return await repository.searchWallpaperLoad(query, page);
  }
}
