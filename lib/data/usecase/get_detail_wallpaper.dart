import '../models/model.dart';
import '../repository/repository.dart';

class GetDetailWallpaper {
  final DetailWallpaperRepository _repository;

  GetDetailWallpaper(this._repository);

  Future<WallpaperModel> execute(int id) async {
    return await _repository.detailWallpaper(id);
  }
}
