import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/presentation/presentation.dart';
import 'package:mockito/mockito.dart';

import '../../../helper/mock.dart';

void main() {
  late MockGetCategorizedWallpaper getCategorizedWallpaper;

  late CategorizedWallpaperCubit categoryCubit;

  setUp(() {
    getCategorizedWallpaper = MockGetCategorizedWallpaper();
    categoryCubit = CategorizedWallpaperCubit(getCategorizedWallpaper);
  });

  final tWallpapers = <Wallpaper>[];

  test('.initial() should be empty', () {
    expect(categoryCubit.state, const CategorizedWallpaperState.initial());
  });

  blocTest<CategorizedWallpaperCubit, CategorizedWallpaperState>(
    'emits [CategorizedWallpaperState.loading(), CategorizedWallpaperState.loaded()] when categorizedRepo.call() succeeds.',
    build: () {
      when(getCategorizedWallpaper.call(any))
          .thenAnswer((_) async => Right(tWallpapers));
      return categoryCubit;
    },
    act: (cubit) => cubit.categoryWallpaper('category'),
    wait: const Duration(milliseconds: 500),
    expect: () => <CategorizedWallpaperState>[
      const CategorizedWallpaperState.loading(),
      CategorizedWallpaperState.loaded(tWallpapers),
    ],
    verify: (bloc) {
      verify(getCategorizedWallpaper.call(any));
    },
  );

  blocTest<CategorizedWallpaperCubit, CategorizedWallpaperState>(
    'emits [CategorizedWallpaperState.loading(), CategorizedWallpaperState.error()] when categorizedRepo.call() fails',
    build: () {
      when(getCategorizedWallpaper.call(any))
          .thenAnswer((_) async => const Left(ServerFailure('Error Message')));
      return categoryCubit;
    },
    act: (cubit) => cubit.categoryWallpaper('category'),
    expect: () => <CategorizedWallpaperState>[
      const CategorizedWallpaperState.loading(),
      const CategorizedWallpaperState.error('Error Message'),
    ],
    verify: (bloc) {
      verify(getCategorizedWallpaper.call(any));
    },
  );
}
