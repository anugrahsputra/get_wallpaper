import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock.dart';

void main() {
  MockWallpaperRepository mockRepository = MockWallpaperRepository();
  GetSearchWallpaper searchWallpaper = GetSearchWallpaper(mockRepository);

  final tWallpapers = <Wallpaper>[];

  group('search wallpaper usecase', () {
    test('should get search wallpaper list from repository', () async {
      when(mockRepository.searchWallpaper(any, any))
          .thenAnswer((_) async => Right(tWallpapers));

      final result = await searchWallpaper.call('query', 1);

      expect(result, Right(tWallpapers));
    });

    test('should load more data on search wallpaper from repository', () async {
      when(mockRepository.searchWallpaperLoad(any, any))
          .thenAnswer((_) async => Right(tWallpapers));

      final result = await searchWallpaper.loadMore('query', 1);

      expect(result, Right(tWallpapers));
    });
  });
}
