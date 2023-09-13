import '../models/model.dart';
import '../repository/repository.dart';

class SearchWallpaper {
  final SearchWallpaperRepository repository;

  SearchWallpaper(this.repository);

  Future<List<WallpaperModel>> call(String query) async {
    return await repository.searchWallpaper(query);
  }
}
