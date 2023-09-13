import 'package:dio/dio.dart';

import '../data/models/model.dart';
import '../utils/env.dart';

abstract class ApiService {
  Future<List<WallpaperModel>> listWallpaper();
  Future<WallpaperModel> detailWallpaper(int id);
  Future<List<WallpaperModel>> searchWallpaper(String query, {int page = 1});
  Future<List<WallpaperModel>> categorizedWallpaper(String category);
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
  Future<List<WallpaperModel>> listWallpaper() async {
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
          .map((photo) => WallpaperModel.fromJson(photo))
          .toList()
          .reversed
          .toList();
    } else {
      throw Exception('failed to load wallpapers');
    }
  }

  @override
  Future<WallpaperModel> detailWallpaper(int id) async {
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
      return WallpaperModel.fromJson(data);
    } else {
      throw Exception('failed to load wallpaper');
    }
  }

  @override
  Future<List<WallpaperModel>> searchWallpaper(String query,
      {int page = 1}) async {
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
      return data.map((photo) => WallpaperModel.fromJson(photo)).toList();
    } else {
      throw Exception('failed to load wallpapers');
    }
  }

  @override
  Future<List<WallpaperModel>> categorizedWallpaper(String category) async {
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
        return data.map((photo) => WallpaperModel.fromJson(photo)).toList();
      } else {
        throw Exception('failed to load wallpapers');
      }
    } catch (e) {
      throw Exception('failed to load wallpapers');
    }
  }
}
