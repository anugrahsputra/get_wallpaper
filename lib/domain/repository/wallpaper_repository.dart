import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/data.dart';

abstract class WallpaperRepository {
  Future<Either<Failure, List<Wallpaper>>> categorizedWallpaper(
      String category);
  Future<Either<Failure, Wallpaper>> detailWallpaper(int id);
  Future<Either<Failure, List<Wallpaper>>> listWallpaper();
  Future<Either<Failure, List<Wallpaper>>> searchWallpaper(String query);
  Future<Either<Failure, List<Wallpaper>>> searchWallpaperLoad(
      String query, int page);
}
