import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock.dart';

void main() {
  late WallpaperRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = WallpaperRemoteDataSourceImpl(mockDioClient);
  });

  const String curated = Env.curatedWallpaper;
  const String detail = Env.detailWallpaper;
  const String search = Env.searchWallpaper;
  const int page = 1;

  group('listWallpaper', () {
    test('should load list of wallpaper', () async {
      final response = Response(
        data: {
          'photos': [],
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockDioClient.get(any)).thenAnswer((_) async => response);

      await dataSource.listWallpaper(page);

      verify(mockDioClient.get('${curated}per_page=20&page=$page'));
    });
  });

  group('detailWallpaper', () {
    test('should load detail of wallpaper', () async {
      const id = 1;
      final response = Response(
        data: {
          "id": 2014422,
          "width": 3024,
          "height": 3024,
          "url":
              "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
          "photographer": "Joey Farina",
          "photographer_url": "https://www.pexels.com/@joey",
          "photographer_id": 680589,
          "avg_color": "#978E82",
          "src": {
            "original":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg",
            "large2x":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
            "large":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
            "medium":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350",
            "small":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130",
            "portrait":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
            "landscape":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
            "tiny":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
          },
          "liked": false,
          "alt": "Brown Rocks During Golden Hour"
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockDioClient.get(any)).thenAnswer((_) async => response);

      await dataSource.detailWallpaper(id);

      verify(mockDioClient.get('$detail$id'));
    });
  });

  group('searchWallpaper', () {
    test('should load list of wallpaper based on query', () async {
      const query = 'nature';
      final response = Response(
        data: {
          'photos': [],
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockDioClient.get(any)).thenAnswer((_) async => response);

      await dataSource.searchWallpaper(query, page);

      verify(mockDioClient.get('$search$query&per_page=20&page=$page'));
    });
  });

  group('categorizedWallpaper', () {
    test('should load list of wallpaper based on category', () async {
      const category = 'nature';
      final response = Response(
        data: {
          'photos': [],
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockDioClient.get(any)).thenAnswer((_) async => response);

      await dataSource.categorizedWallpaper(category, page);

      verify(mockDioClient.get('$search$category&per_page=20&page=$page'));
    });
  });
}
