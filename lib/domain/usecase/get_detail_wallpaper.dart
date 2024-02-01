import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../domain.dart';

class GetDetailWallpaper {
  final WallpaperRepository _repository;

  GetDetailWallpaper(this._repository);

  /// Executes the use case and returns the detailed information of the wallpaper with the given [id].
  ///
  /// Returns a [Future] that completes with an [Either] containing a [Failure] if an error occurs,
  /// or a [Wallpaper] object if the operation is successful.
  Future<Either<Failure, Wallpaper>> execute(int id) async {
    return await _repository.detailWallpaper(id);
  }
}
