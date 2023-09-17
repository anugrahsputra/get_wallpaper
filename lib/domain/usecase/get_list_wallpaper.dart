import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../domain.dart';

class GetListWallpaper {
  final WallpaperRepository _repository;

  GetListWallpaper(this._repository);

  Future<Either<Failure, List<Wallpaper>>> call() async {
    return await _repository.listWallpaper();
  }
}
