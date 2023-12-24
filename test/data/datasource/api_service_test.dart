import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock.dart';

void main() {
  const baseUrl = Env.baseUrl;
  const curated = Env.curatedWallpaper;
  const detail = Env.detailWallpaper;
  const search = Env.searchWallpaper;

  MockDio dio = MockDio();
  ApiService api = ApiServiceImpl(dio);

  group('listWallpaper()', () {
    test('should load from api by calling dio.get', () async {
      Response response = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 200,
          data: {
            "photos": [],
          });

      when(
        dio.get(
          '$baseUrl${curated}per_page=20',
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) => Future.value(response),
      );

      await api.listWallpaper();

      verify(
        dio.get(
          '$baseUrl${curated}per_page=20',
          options: anyNamed("options"),
        ),
      );
    });

    test('should thrown exception when getting error', () async {
      Exception exception = Exception('unknown');

      when(dio.get(
        '$baseUrl${curated}per_page=20',
        options: anyNamed('options'),
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(exception);

      expect(() => api.listWallpaper(), throwsA(exception));
    });
  });

  group('detailWallpaper()', () {
    int id = 2014422;
    test('should load from api by calling dio.get', () async {
      Response response = Response(
        requestOptions: RequestOptions(path: ""),
        statusCode: 200,
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
      );

      when(
        dio.get(
          '$baseUrl$detail$id',
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) => Future.value(response),
      );

      await api.detailWallpaper(id);

      verify(
        dio.get(
          '$baseUrl$detail$id',
          options: anyNamed("options"),
        ),
      );
    });

    test('should thrown exception when getting error', () async {
      Exception exception = Exception('unknown');

      when(dio.get(
        '$baseUrl$detail$id',
        options: anyNamed('options'),
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(exception);

      expect(() => api.detailWallpaper(id), throwsA(exception));
    });
  });

  group('searchWallpaper()', () {
    String query = 'minimal';
    int page = 1;
    test('should load from api by calling dio.get', () async {
      Response response = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 200,
          data: {
            "photos": [],
          });

      when(
        dio.get(
          '$baseUrl$search$query&page=$page',
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) => Future.value(response),
      );

      await api.searchWallpaper(query, page);

      verify(
        dio.get(
          '$baseUrl$search$query&page=$page',
          options: anyNamed("options"),
        ),
      );
    });

    test('should thrown exception when getting error', () async {
      Exception exception = Exception('unknown');

      when(dio.get(
        '$baseUrl$search$query&page=$page',
        options: anyNamed('options'),
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(exception);

      expect(() => api.searchWallpaper(query, page), throwsA(exception));
    });
  });

  group('categorizedWallpaper()', () {
    String category = 'nature';
    test('should load from api by calling dio.get', () async {
      Response response = Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 200,
          data: {
            "photos": [],
          });

      when(
        dio.get(
          '$baseUrl$search$category&per_page=20',
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (_) => Future.value(response),
      );

      await api.categorizedWallpaper(category);

      verify(
        dio.get(
          '$baseUrl$search$category&per_page=20',
          options: anyNamed("options"),
        ),
      );
    });

    test('should thrown exception when getting error', () async {
      Exception exception = Exception('failed to load wallpapers');

      when(
        dio.get(
          '$baseUrl$search$category&per_page=20',
          options: anyNamed('options'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(exception);

      expect(
          () => api.categorizedWallpaper(category), throwsA(isA<Exception>()));
    });
  });
}
