import '../models/model.dart';
import '../repository/list_wallpaper_repository.dart';

class GetListWallpaper {
  final ListWallpaperRepository _repository;

  GetListWallpaper(this._repository);

  Future<List<WallpaperModel>> call() async {
    return await _repository.listWallpaper();
  }
}
