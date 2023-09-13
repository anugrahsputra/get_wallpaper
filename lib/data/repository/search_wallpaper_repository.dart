import 'package:get_wallpaper/services/api_service.dart';

import '../models/model.dart';

abstract class SearchWallpaperRepository {
  Future<List<WallpaperModel>> searchWallpaper(String query);
  Future<List<WallpaperModel>> loadMore(String query, int page);
}

class SearchwallpaperRepositoryImpl implements SearchWallpaperRepository {
  final ApiService apiService;

  SearchwallpaperRepositoryImpl(this.apiService);

  @override
  Future<List<WallpaperModel>> searchWallpaper(String query) async {
    final wallpaper = await apiService.searchWallpaper(query);
    return wallpaper;
  }

  @override
  Future<List<WallpaperModel>> loadMore(String query, int page) async {
    final wallpaper = await apiService.searchWallpaper(query, page: page);
    return wallpaper;
  }
}
