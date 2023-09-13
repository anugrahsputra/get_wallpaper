import '../../services/api_service.dart';
import '../models/model.dart';

abstract class CategorizedRepository {
  Future<List<WallpaperModel>> categorizedWallpaper(String category);
}

class CategorizedRepositoryImpl implements CategorizedRepository {
  final ApiService apiService;

  CategorizedRepositoryImpl(this.apiService);

  @override
  Future<List<WallpaperModel>> categorizedWallpaper(String category) {
    return apiService.categorizedWallpaper(category);
  }
}
