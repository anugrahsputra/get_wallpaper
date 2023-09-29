import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/presentation/presentation.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_data.dart';
import '../../../helper/mock.dart';

void main() {
  late MockGetDetailWallpaper getDetailWallpaper;

  late DetailWallpaperCubit detailWallpaper;

  setUp(() {
    getDetailWallpaper = MockGetDetailWallpaper();
    detailWallpaper = DetailWallpaperCubit(getDetailWallpaper);
  });

  test('initial() should be empty', () {
    expect(detailWallpaper.state, const DetailWallpaperState.initial());
  });

  blocTest<DetailWallpaperCubit, DetailWallpaperState>(
    'emits [DetailWallpaperState.loading(), DetailWallpaperState.loaded()] when getDetailWallpaper.execute() succeeds.',
    build: () {
      when(getDetailWallpaper.execute(any))
          .thenAnswer((_) async => const Right(tWallpaper));
      return detailWallpaper;
    },
    act: (cubit) => cubit.getWallpaperDetail(1),
    wait: const Duration(milliseconds: 500),
    expect: () => const <DetailWallpaperState>[
      DetailWallpaperState.loading(),
      DetailWallpaperState.loaded(tWallpaper),
    ],
    verify: (bloc) {
      verify(getDetailWallpaper.execute(any));
    },
  );

  blocTest<DetailWallpaperCubit, DetailWallpaperState>(
    'emits [DetailWallpaperState.loading(), DetailWallpaperState.error()] when getDetailWallpaper.execute() fails.',
    build: () {
      when(getDetailWallpaper.execute(any))
          .thenAnswer((_) async => const Left(ServerFailure('Error Message')));
      return detailWallpaper;
    },
    act: (cubit) => cubit.getWallpaperDetail(1),
    expect: () => const <DetailWallpaperState>[
      DetailWallpaperState.loading(),
      DetailWallpaperState.error('Error Message'),
    ],
    verify: (bloc) => verify(getDetailWallpaper.execute(any)),
  );
}
