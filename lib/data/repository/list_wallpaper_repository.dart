import '../../services/api_service.dart';
import '../models/model.dart';

abstract class ListWallpaperRepository {
  Future<List<WallpaperModel>> listWallpaper();
}

class ListWallpaperRepositoryImpl implements ListWallpaperRepository {
  final ApiService apiService;

  ListWallpaperRepositoryImpl(this.apiService);

  @override
  Future<List<WallpaperModel>> listWallpaper() {
    return apiService.listWallpaper();
  }
}
