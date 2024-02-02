import '../../core/core.dart';
import '../data.dart';

abstract class WallpaperRemoteDataSource {
  /// Retrieves a list of wallpapers.
  ///
  /// Returns a [Future] that resolves to a list of [Wallpaper] objects.
  Future<List<WallpaperModel>> listWallpaper(int page);

  /// Retrieves the details of a specific wallpaper.
  ///
  /// [id] - The ID of the wallpaper to retrieve.
  ///
  /// Returns a [Future] that resolves to a [Wallpaper] object.
  Future<WallpaperModel> detailWallpaper(int id);

  /// Searches for wallpapers based on a query and page number.
  ///
  /// [query] - The search query.
  /// [page] - The page number of the search results.
  ///
  /// Returns a [Future] that resolves to a list of [Wallpaper] objects.
  Future<List<WallpaperModel>> searchWallpaper(String query, int page);

  /// Retrieves a list of wallpapers based on a specific category.
  ///
  /// [category] - The category of the wallpapers to retrieve.
  ///
  /// Returns a [Future] that resolves to a list of [Wallpaper] objects.
  Future<List<WallpaperModel>> categorizedWallpaper(String category, int page);
}

class WallpaperRemoteDataSourceImpl implements WallpaperRemoteDataSource {
  static const String _curated = Env.curatedWallpaper;
  static const String _detail = Env.detailWallpaper;
  static const String _search = Env.searchWallpaper;
  final DioClient dioClient;

  WallpaperRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<WallpaperModel>> categorizedWallpaper(
      String category, int page) async {
    final response = await dioClient.get('${_curated}per_page=20&page=$page');

    final List<dynamic> data = response.data['photos'];
    return data.map((photo) => WallpaperModel.fromJson(photo)).toList();
  }

  @override
  Future<WallpaperModel> detailWallpaper(int id) async {
    final response = await dioClient.get('$_detail$id');

    return WallpaperModel.fromJson(response.data);
  }

  @override
  Future<List<WallpaperModel>> listWallpaper(int page) async {
    final respoonse = await dioClient.get('${_curated}per_page=20&page=$page');

    final List<dynamic> data = respoonse.data['photos'];
    return data
        .map((photo) => WallpaperModel.fromJson(photo))
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<List<WallpaperModel>> searchWallpaper(String query, int page) async {
    final response =
        await dioClient.get('$_search$query&per_page=20&page=$page');

    final List<dynamic> data = response.data['photos'];
    return data.map((photo) => WallpaperModel.fromJson(photo)).toList();
  }
}
