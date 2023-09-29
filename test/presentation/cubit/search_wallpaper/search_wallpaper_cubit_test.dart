import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/presentation/presentation.dart';
import 'package:mockito/mockito.dart';

import '../../../helper/mock.dart';

void main() {
  late MockGetSearchWallpaper searchWallpaper;
  late SearchWallpaperCubit searchWallpaperCubit;

  setUp(() {
    searchWallpaper = MockGetSearchWallpaper();
    searchWallpaperCubit = SearchWallpaperCubit(searchWallpaper);
  });

  final tWallpapers = <Wallpaper>[];

  test('.initial() should be empty', () {
    expect(searchWallpaperCubit.state, const SearchWallpaperState.initial());
  });

  group('searchWallpaper()', () {
    blocTest<SearchWallpaperCubit, SearchWallpaperState>(
      'emits [SearchWallpaperState.loading(), SearchWallpaperState.loaded()] when searchWallpaper.call() succeeds',
      build: () {
        when(searchWallpaper.call(any))
            .thenAnswer((_) async => Right(tWallpapers));
        return searchWallpaperCubit;
      },
      wait: const Duration(milliseconds: 500),
      act: (cubit) => cubit.searchWallpaper('query'),
      expect: () => <SearchWallpaperState>[
        const SearchWallpaperState.loading(),
        SearchWallpaperState.loaded(tWallpapers),
      ],
      verify: (bloc) {
        verify(searchWallpaper.call(any));
      },
    );

    blocTest<SearchWallpaperCubit, SearchWallpaperState>(
      'emits [SearchWallpaperState.loading(), SearchWallpaperState.error()] when searchWallpaper.call() fails',
      build: () {
        when(searchWallpaper.call(any)).thenAnswer(
            (_) async => const Left(ServerFailure('Error Message')));
        return searchWallpaperCubit;
      },
      wait: const Duration(milliseconds: 500),
      act: (cubit) => cubit.searchWallpaper('query'),
      expect: () => const <SearchWallpaperState>[
        SearchWallpaperState.loading(),
        SearchWallpaperState.error('Error Message'),
      ],
      verify: (bloc) {
        verify(searchWallpaper.call(any));
      },
    );
  });

  group('loadMore()', () {
    blocTest<SearchWallpaperCubit, SearchWallpaperState>(
      'emits [SearchWallpaperState.loading(), SearchWallpaperState.loaded()] when searchWallpaper.loadMore() succeeds',
      build: () {
        when(searchWallpaper.loadMore(any, any))
            .thenAnswer((_) async => Right(tWallpapers));
        return searchWallpaperCubit;
      },
      wait: const Duration(milliseconds: 500),
      act: (cubit) => cubit.loadMore('query'),
      expect: () => <SearchWallpaperState>[
        const SearchWallpaperState.loading(),
        SearchWallpaperState.loaded(tWallpapers),
      ],
      verify: (bloc) {
        verify(searchWallpaper.loadMore(any, any));
      },
    );

    blocTest<SearchWallpaperCubit, SearchWallpaperState>(
      'emits [SearchWallpaperState.loading(), SearchWallpaperState.error()] when searchWallpaper.loadMore() fails',
      build: () {
        when(searchWallpaper.loadMore(any, any)).thenAnswer(
            (_) async => const Left(ServerFailure('Error Message')));
        return searchWallpaperCubit;
      },
      wait: const Duration(milliseconds: 500),
      act: (cubit) => cubit.loadMore('query'),
      expect: () => const <SearchWallpaperState>[
        SearchWallpaperState.loading(),
        SearchWallpaperState.error('Error Message'),
      ],
      verify: (bloc) {
        verify(searchWallpaper.loadMore(any, any));
      },
    );
  });

  blocTest<SearchWallpaperCubit, SearchWallpaperState>(
    'emits [SearchWallpaperState.initial()] when searchWallpaper.call() succeeds',
    build: () {
      when(searchWallpaper.call(any))
          .thenAnswer((_) async => Right(tWallpapers));
      return searchWallpaperCubit;
    },
    wait: const Duration(milliseconds: 500),
    act: (cubit) => cubit.clearSearch(),
    expect: () => <SearchWallpaperState>[
      const SearchWallpaperState.initial(),
    ],
    verify: (bloc) {
      verifyNever(searchWallpaper.call(any));
    },
  );
}
