import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../data.dart';

abstract class ApiService {
  /// Retrieves a list of wallpapers.
  ///
  /// Returns a [Future] that resolves to a list of [Wallpaper] objects.
  Future<List<Wallpaper>> listWallpaper();

  /// Retrieves the details of a specific wallpaper.
  ///
  /// [id] - The ID of the wallpaper to retrieve.
  ///
  /// Returns a [Future] that resolves to a [Wallpaper] object.
  Future<Wallpaper> detailWallpaper(int id);

  /// Searches for wallpapers based on a query and page number.
  ///
  /// [query] - The search query.
  /// [page] - The page number of the search results.
  ///
  /// Returns a [Future] that resolves to a list of [Wallpaper] objects.
  Future<List<Wallpaper>> searchWallpaper(String query, int page);

  /// Retrieves a list of wallpapers based on a specific category.
  ///
  /// [category] - The category of the wallpapers to retrieve.
  ///
  /// Returns a [Future] that resolves to a list of [Wallpaper] objects.
  Future<List<Wallpaper>> categorizedWallpaper(String category);
}

class ApiServiceImpl implements ApiService {
  static const String _baseUrl = Env.baseUrl;
  static const String _apiKey = Env.apiKey;
  static const String _curated = Env.curatedWallpaper;
  static const String _detail = Env.detailWallpaper;
  static const String _search = Env.searchWallpaper;

  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<List<Wallpaper>> listWallpaper() async {
    final response = await _dio.get(
      '$_baseUrl${_curated}per_page=20',
      options: Options(
        headers: {
          'Authorization': _apiKey,
        },
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['photos'];
      return data
          .map((photo) => Wallpaper.fromJson(photo))
          .toList()
          .reversed
          .toList();
    } else {
      throw Exception('failed to load wallpapers');
    }
  }

  @override
  Future<Wallpaper> detailWallpaper(int id) async {
    final response = await _dio.get(
      '$_baseUrl$_detail$id',
      options: Options(
        headers: {
          'Authorization': _apiKey,
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return Wallpaper.fromJson(data);
    } else {
      throw Exception('failed to load wallpaper');
    }
  }

  @override
  Future<List<Wallpaper>> searchWallpaper(String query, int page) async {
    final response = await _dio.get(
      '$_baseUrl$_search$query&page=$page',
      options: Options(
        headers: {
          'Authorization': _apiKey,
        },
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['photos'];
      return data.map((photo) => Wallpaper.fromJson(photo)).toList();
    } else {
      throw Exception('failed to load wallpapers');
    }
  }

  @override
  Future<List<Wallpaper>> categorizedWallpaper(String category) async {
    try {
      final response = await _dio.get(
        '$_baseUrl$_search$category&per_page=20',
        options: Options(
          headers: {
            'Authorization': _apiKey,
          },
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['photos'];
        return data.map((photo) => Wallpaper.fromJson(photo)).toList();
      } else {
        throw Exception('failed to load wallpapers');
      }
    } catch (e) {
      throw Exception('failed to load wallpapers');
    }
  }
}
