import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

class GetCategorizedWallpaper {
  final WallpaperRepository categorizedRepo;

  GetCategorizedWallpaper(this.categorizedRepo);

  Future<Either<Failure, List<Wallpaper>>> call(String category) async {
    return categorizedRepo.categorizedWallpaper(category);
  }
}
