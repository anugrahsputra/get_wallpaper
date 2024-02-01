import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../domain.dart';

class GetListWallpaper {
  final WallpaperRepository _repository;

  GetListWallpaper(this._repository);

  /// Retrieves a list of wallpapers from the repository.
  ///
  /// Returns a [Future] that resolves to an [Either] object, which can contain either a [Failure] or a list of [Wallpaper] objects.
  Future<Either<Failure, List<Wallpaper>>> call(int page) async {
    return await _repository.listWallpaper(page);
  }
}
