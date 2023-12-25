import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

class GetCategorizedWallpaper {
  final WallpaperRepository categorizedRepo;

  GetCategorizedWallpaper(this.categorizedRepo);

  /// Retrieves a list of wallpapers for the specified category.
  ///
  /// Returns a [Future] that completes with an [Either] containing a [Failure] or a list of [Wallpaper].
  Future<Either<Failure, List<Wallpaper>>> call(String category) async {
    return categorizedRepo.categorizedWallpaper(category);
  }
}
