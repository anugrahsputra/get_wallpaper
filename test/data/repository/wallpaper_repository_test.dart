import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock.dart';

void main() {
  MockApiService api = MockApiService();
  WallpaperRepository repository = WallpaperRepositoryImpl(api);

  const tImageSource = ImageSource(
    original:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg",
    large2x:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    large:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
    medium:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350",
    small:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130",
    portrait:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
    landscape:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
    tiny:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280",
  );

  const tWallpaper = Wallpaper(
    id: 2014422,
    width: 3024,
    height: 3024,
    url: "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
    photographer: "Joey Farina",
    photographerUrl: "https://www.pexels.com/@joey",
    photographerId: 680589,
    avgColor: "#978E82",
    src: tImageSource,
    liked: false,
    alt: "Brown Rocks During Golden Hour",
  );

  final tWallpaperList = <Wallpaper>[];

  group('.listWallpaper()', () {
    test('should return list wallpaper when call to api is successfull',
        () async {
      when(api.listWallpaper()).thenAnswer((_) async => tWallpaperList);

      final result = await repository.listWallpaper();

      verify(api.listWallpaper());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tWallpaperList);
    });

    test('should return server failure when call to api is unsuccessfull',
        () async {
      when(api.listWallpaper()).thenThrow(ServerException());

      final result = await repository.listWallpaper();

      verify(api.listWallpaper());
      expect(result, equals(const Left(ServerFailure('Server Failure'))));
    });

    test('should return connection failure when call to api is unsuccessfull',
        () async {
      when(api.listWallpaper())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.listWallpaper();

      verify(api.listWallpaper());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('.categorizedWallpaper()', () {
    test(
        'should return list of categorized wallpaper when call to api is successfull',
        () async {
      when(api.categorizedWallpaper(any))
          .thenAnswer((_) async => tWallpaperList);

      final result = await repository.categorizedWallpaper('category');

      verify(api.categorizedWallpaper(any));

      final resultList = result.getOrElse(() => []);
      expect(resultList, tWallpaperList);
    });

    test('should return server failure when call to api is unsuccessfull',
        () async {
      when(api.categorizedWallpaper(any)).thenThrow(ServerException());

      final result = await repository.categorizedWallpaper('category');

      verify(api.categorizedWallpaper(any));
      expect(result, equals(const Left(ServerFailure('Server Failure'))));
    });

    test('should return connection failure when call to api is unsuccessfull',
        () async {
      when(api.categorizedWallpaper(any))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.categorizedWallpaper('category');

      verify(api.categorizedWallpaper(any));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('.detailWallpaper()', () {
    test('should return detail wallpaper when call to api is successful',
        () async {
      when(api.detailWallpaper(any)).thenAnswer((_) async => tWallpaper);

      final result = await repository.detailWallpaper(1);

      verify(api.detailWallpaper(any));
      expect(result, equals(const Right(tWallpaper)));
    });

    test('should return server failure when call to api is unsuccessfull',
        () async {
      when(api.detailWallpaper(any)).thenThrow(ServerException());

      final result = await repository.detailWallpaper(1);

      verify(api.detailWallpaper(any));
      expect(result, equals(const Left(ServerFailure('Server Failure'))));
    });

    test('should return connection failure when call to api is unsuccessfull',
        () async {
      when(api.detailWallpaper(any))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.detailWallpaper(1);

      verify(api.detailWallpaper(any));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('.searchWallpaper()', () {
    test('should return search wallpaper when call to api is successfull',
        () async {
      when(api.searchWallpaper(any)).thenAnswer((_) async => tWallpaperList);

      final result = await repository.searchWallpaper('query');
      final resultList = result.getOrElse(() => []);

      verify(api.searchWallpaper(any));
      expect(resultList, tWallpaperList);
    });

    test('should return server failure when call to api is unsuccessfull',
        () async {
      when(api.searchWallpaper(any)).thenThrow(ServerException());

      final result = await repository.searchWallpaper('query');

      verify(api.searchWallpaper(any));
      expect(result, equals(const Left(ServerFailure('Server Failure'))));
    });

    test('should return connection failure when call to api is unsuccessfull',
        () async {
      when(api.searchWallpaper(any))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.searchWallpaper('query');

      verify(api.searchWallpaper(any));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('.searchWallpaperLoad()', () {
    test('should return search wallpaper when call to api is successfull',
        () async {
      when(api.searchWallpaper(any)).thenAnswer((_) async => tWallpaperList);

      final result = await repository.searchWallpaperLoad('query', 1);
      final resultList = result.getOrElse(() => []);

      verify(api.searchWallpaper(any));
      expect(resultList, tWallpaperList);
    });

    test('should return server failure when call to api is unsuccessfull',
        () async {
      when(api.searchWallpaper(any)).thenThrow(ServerException());

      final result = await repository.searchWallpaperLoad('query', 1);

      verify(api.searchWallpaper(any));
      expect(result, equals(const Left(ServerFailure('Server Failure'))));
    });

    test('should return connection failure when call to api is unsuccessfull',
        () async {
      when(api.searchWallpaper(any))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.searchWallpaperLoad('query', 1);

      verify(api.searchWallpaper(any));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
