import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/presentation/bloc/blocs.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock.dart';

void main() {
  late MockGetListWallpaper mockGetListWallpaper;
  late MockGetCategorizedWallpaper mockGetCategorizedWallpaper;
  late WallpapersBloc wallpapersBloc;

  setUp(() {
    mockGetListWallpaper = MockGetListWallpaper();
    mockGetCategorizedWallpaper = MockGetCategorizedWallpaper();
    mockGetCategorizedWallpaper = MockGetCategorizedWallpaper();
    wallpapersBloc = WallpapersBloc(
      getListRepo: mockGetListWallpaper,
      categorizedRepo: mockGetCategorizedWallpaper,
    );
  });

  final tWallpaperList = <Wallpaper>[];

  test('initial state should be Initial', () {
    expect(wallpapersBloc.state, equals(const Initial()));
  });

  group('list wallpaper', () {
    blocTest<WallpapersBloc, WallpapersState>(
      'should emit [Loading, CuratedLoaded] when success',
      build: () {
        when(mockGetListWallpaper.call(any))
            .thenAnswer((_) async => Right(tWallpaperList));
        return wallpapersBloc;
      },
      act: (bloc) => bloc.add(const Curated(1)),
      expect: () => [
        const Loading(),
        CuratedLoaded(tWallpaperList),
      ],
    );

    blocTest<WallpapersBloc, WallpapersState>(
      'should emit [Loading, Error] when failed',
      build: () {
        when(mockGetListWallpaper.call(any))
            .thenAnswer((_) async => const Left(ServerFailure('')));
        return wallpapersBloc;
      },
      act: (bloc) => bloc.add(const Curated(1)),
      expect: () => [
        const Loading(),
        const Error(''),
      ],
    );
  });

  group('categorized wallpaper', () {
    blocTest<WallpapersBloc, WallpapersState>(
      'should emit [Loading, CategorizedLoaded] when success',
      build: () {
        when(mockGetCategorizedWallpaper.call(any, any))
            .thenAnswer((_) async => Right(tWallpaperList));
        return wallpapersBloc;
      },
      act: (bloc) => bloc.add(const Category('', 1)),
      expect: () => [
        const Loading(),
        CategoryLoaded(tWallpaperList),
      ],
    );

    blocTest<WallpapersBloc, WallpapersState>(
      'should emit [Loading, Error] when failed',
      build: () {
        when(mockGetCategorizedWallpaper.call(any, any)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return wallpapersBloc;
      },
      act: (bloc) => bloc.add(const Category('', 1)),
      expect: () => [
        const Loading(),
        const Error('Server Failure'),
      ],
    );
  });

  group('load more', () {
    // TODO: fix this test
    // blocTest(
    //   'should emit [Loading, CuratedLoaded] when successful',
    //   build: () {
    //     when(mockGetListWallpaper.call(any))
    //         .thenAnswer((_) async => Right(tWallpaperList));
    //     return wallpapersBloc;
    //   },
    //   act: (bloc) => bloc.add(const LoadMore('nature', 1)),
    //   expect: () => [
    //     const CuratedLoaded([]),
    //   ],
    //   verify: (_) {
    //     verify(mockGetListWallpaper.call(any));
    //   },
    // );
    //
    // blocTest(
    //   'should emit [Loading, CuratedLoaded] when successful',
    //   build: () {
    //     when(mockGetCategorizedWallpaper.call(any, any))
    //         .thenAnswer((_) async => Right(tWallpaperList));
    //     return wallpapersBloc;
    //   },
    //   act: (bloc) => bloc.add(const LoadMore('nature', 1)),
    //   expect: () => [
    //     const CategoryLoaded([]),
    //   ],
    //   verify: (_) {
    //     verify(mockGetCategorizedWallpaper.call(any, any));
    //   },
    // );
  });
}
