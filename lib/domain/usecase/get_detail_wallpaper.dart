import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

class GetDetailWallpaper {
  final WallpaperRepository _repository;

  GetDetailWallpaper(this._repository);

  Future<Either<Failure, Wallpaper>> execute(int id) async {
    return await _repository.detailWallpaper(id);
  }
}
