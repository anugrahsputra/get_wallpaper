import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/data.dart';

abstract class WallpaperRepository {
  /// Retrieves a list of wallpapers based on a specified category.
  /// Returns a [Future] that resolves to an [Either] object, which can contain either a [Failure] or a list of [Wallpaper] objects.
  Future<Either<Failure, List<Wallpaper>>> categorizedWallpaper(
      String category, int page);

  /// Retrieves detailed information about a specific wallpaper.
  /// Returns a [Future] that resolves to an [Either] object, which can contain either a [Failure] or a [Wallpaper] object.
  Future<Either<Failure, Wallpaper>> detailWallpaper(int id);

  /// Retrieves a list of all wallpapers.
  /// Returns a [Future] that resolves to an [Either] object, which can contain either a [Failure] or a list of [Wallpaper] objects.
  Future<Either<Failure, List<Wallpaper>>> listWallpaper(int page);

  /// Searches for wallpapers based on a specified query.
  /// Returns a [Future] that resolves to an [Either] object, which can contain either a [Failure] or a list of [Wallpaper] objects.
  Future<Either<Failure, List<Wallpaper>>> searchWallpaper(
      String query, int page);

  /// Searches for wallpapers based on a specified query and page number.
  /// Returns a [Future] that resolves to an [Either] object, which can contain either a [Failure] or a list of [Wallpaper] objects.
  Future<Either<Failure, List<Wallpaper>>> searchWallpaperLoad(
      String query, int page);
}
