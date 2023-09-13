import 'package:get_wallpaper/data/repository/cateogorized_repository.dart';

import '../models/model.dart';

class GetCategorizedWallpaper {
  final CategorizedRepository categorizedRepo;

  GetCategorizedWallpaper(this.categorizedRepo);

  Future<List<WallpaperModel>> call(String category) async {
    return categorizedRepo.categorizedWallpaper(category);
  }
}
