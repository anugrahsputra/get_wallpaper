import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock.dart';

void main() {
  MockWallpaperRepository repository = MockWallpaperRepository();
  GetCategorizedWallpaper categorizedWallpaper =
      GetCategorizedWallpaper(repository);

  final tWallpapers = <Wallpaper>[];

  test('should get categorized wallpaper list from repository', () async {
    when(repository.categorizedWallpaper(any, any))
        .thenAnswer((_) async => Right(tWallpapers));

    final result = await categorizedWallpaper.call('category', 1);

    expect(result, Right(tWallpapers));
  });
}
