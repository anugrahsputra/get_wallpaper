import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../domain.dart';

class GetSearchWallpaper {
  final WallpaperRepository repository;

  GetSearchWallpaper(this.repository);

  /// Calls the repository's searchWallpaper method to get a list of wallpapers based on the provided query and page number.
  ///
  /// Returns a Future that resolves to an Either containing a Failure or a List of Wallpaper objects.
  Future<Either<Failure, List<Wallpaper>>> call(String query, int page) async {
    return await repository.searchWallpaper(query, page);
  }

  /// Calls the repository's searchWallpaperLoad method to load more wallpapers based on the provided query and page number.
  ///
  /// Returns a Future that resolves to an Either containing a Failure or a List of Wallpaper objects.
  Future<Either<Failure, List<Wallpaper>>> loadMore(
      String query, int page) async {
    return await repository.searchWallpaperLoad(query, page);
  }
}
