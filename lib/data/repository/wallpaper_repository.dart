import '../../services/api_service.dart';
import '../models/model.dart';

abstract class WallpaperRepository {
  Future<List<WallpaperModel>> categorizedWallpaper(String category);
  Future<WallpaperModel> detailWallpaper(int id);
  Future<List<WallpaperModel>> listWallpaper();
  Future<List<WallpaperModel>> searchWallpaper(String query);
}

class WallpaperRepositoryImpl implements WallpaperRepository {
  final ApiService apiService;

  WallpaperRepositoryImpl(this.apiService);

  @override
  Future<List<WallpaperModel>> categorizedWallpaper(String category) {
    return apiService.categorizedWallpaper(category);
  }

  @override
  Future<WallpaperModel> detailWallpaper(int id) async {
    final wallpaper = await apiService.detailWallpaper(id);
    return wallpaper;
  }

  @override
  Future<List<WallpaperModel>> listWallpaper() {
    return apiService.listWallpaper();
  }

  @override
  Future<List<WallpaperModel>> searchWallpaper(String query) {
    return apiService.searchWallpaper(query);
  }
}
