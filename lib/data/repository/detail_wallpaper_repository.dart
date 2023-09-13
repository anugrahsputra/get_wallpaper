import '../../services/api_service.dart';
import '../models/model.dart';

abstract class DetailWallpaperRepository {
  Future<WallpaperModel> detailWallpaper(int id);
}

class DetailWallpaperRepositoryImpl implements DetailWallpaperRepository {
  final ApiService apiService;

  DetailWallpaperRepositoryImpl(this.apiService);

  @override
  Future<WallpaperModel> detailWallpaper(int id) async {
    final wallpaper = await apiService.detailWallpaper(id);
    return wallpaper;
  }
}
