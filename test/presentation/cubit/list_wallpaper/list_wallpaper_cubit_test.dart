import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/presentation/presentation.dart';
import 'package:mockito/mockito.dart';

import '../../../helper/mock.dart';

void main() {
  late MockGetListWallpaper getListWallpaper;
  late ListWallpaperCubit listWallpaperCubit;

  setUp(() {
    getListWallpaper = MockGetListWallpaper();
    listWallpaperCubit = ListWallpaperCubit(getListWallpaper);
  });

  final tWallpapers = <Wallpaper>[];

  test('.initial() should be empty', () {
    expect(listWallpaperCubit.state, const ListWallpaperState.initial());
  });

  blocTest<ListWallpaperCubit, ListWallpaperState>(
    'emits [ListWallpaperState.loading(), ListWallpaperState.loaded()] when getListwallpaper.call() succeds',
    build: () {
      when(getListWallpaper.call()).thenAnswer((_) async => Right(tWallpapers));
      return listWallpaperCubit;
    },
    act: (cubit) => cubit.getWallpaper(),
    wait: const Duration(milliseconds: 500),
    expect: () => <ListWallpaperState>[
      const ListWallpaperState.loading(),
      ListWallpaperState.loaded(tWallpapers)
    ],
    verify: (bloc) {
      verify(getListWallpaper.call());
    },
  );

  blocTest<ListWallpaperCubit, ListWallpaperState>(
    'emits [CategorizedWallpaperState.loading(), CategorizedWallpaperState.error()] when categorizedRepo.call() fails',
    build: () {
      when(getListWallpaper.call())
          .thenAnswer((_) async => const Left(ServerFailure('Error Message')));
      return listWallpaperCubit;
    },
    act: (cubit) => cubit.getWallpaper(),
    expect: () => <ListWallpaperState>[
      const ListWallpaperState.loading(),
      const ListWallpaperState.error('Error Message'),
    ],
    verify: (bloc) {
      verify(getListWallpaper.call());
    },
  );
}
