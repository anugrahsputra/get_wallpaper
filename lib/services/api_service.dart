import 'package:dio/dio.dart';
import 'package:get_wallpaper/models/wallpaper/wallpaper_model.dart';
import 'package:get_wallpaper/utils/env.dart';

class ApiService {
  static const String _baseUrl = Env.baseUrl;
  static const String _apiKey = Env.apiKey;
  static const String _curated = Env.curatedWallpaper;
  static const String _detail = Env.detailWallpaper;
  static const String _search = Env.searchWallpaper;

  final Dio _dio;

  ApiService({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<WallpaperModel>> listWallpaper() async {
    final response = await _dio.get(
      '$_baseUrl${_curated}page=1&per_page=20',
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

  Future<List<WallpaperModel>> searchWallpaper(String query) async {
    final response = await _dio.get(
      '$_baseUrl$_search$query',
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
}
