import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock.dart';

void main() {
  MockWallpaperRepository mockRepository = MockWallpaperRepository();
  GetListWallpaper listWallpaper = GetListWallpaper(mockRepository);

  final tWallpapers = <Wallpaper>[];

  test('should get categorized wallpaper list from repository', () async {
    when(mockRepository.listWallpaper(any))
        .thenAnswer((_) async => Right(tWallpapers));

    final result = await listWallpaper.call(1);

    expect(result, Right(tWallpapers));
  });
}
