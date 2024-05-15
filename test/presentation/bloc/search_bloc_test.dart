import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/domain/domain.dart';
import 'package:get_wallpaper/presentation/bloc/search/search_wallpaper_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock.dart';

void main() {
  late SearchBloc searchBloc;
  late MockGetSearchWallpaper getSearchWallpaper;

  setUp(() {
    getSearchWallpaper = MockGetSearchWallpaper();
    searchBloc = SearchBloc(repository: getSearchWallpaper);
  });

  final tWallpaper = <Wallpaper>[];

  const tQuery = 'black';

  test('initial state should be empty', () {
    expect(searchBloc.state, equals(Initial()));
  });

  group('search wallpaper', () {
    blocTest<SearchBloc, SearchState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(getSearchWallpaper.call(any, any))
            .thenAnswer((_) async => Right(tWallpaper));
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchQuery(tQuery, 1)),
      expect: () => [
        Loading(),
        Loaded(tWallpaper),
      ],
      verify: (_) {
        verify(getSearchWallpaper.call(any, any));
      },
    );

    blocTest(
      'should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(getSearchWallpaper.call(any, any)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchQuery(tQuery, 1)),
      expect: () => [
        Loading(),
        Error('Server Failure'),
      ],
      verify: (_) {
        verify(getSearchWallpaper.call(any, any));
      },
    );
  });

  group('load more', () {
    // TODO: fix this test
    // blocTest(
    //   'should emit [Loaded] when successfull',
    //   build: () {
    //     when(getSearchWallpaper.call(any, any))
    //         .thenAnswer((_) async => Right(tWallpaperList));
    //     return searchBloc;
    //   },
    //   act: (bloc) => bloc.add(More(tQuery, 1)),
    //   expect: () => [
    //     Loaded(tWallpaperList),
    //   ],
    //   verify: (_) {
    //     verify(getSearchWallpaper.call(any, any));
    //   },
    // );

    blocTest(
      'should emit [Error] when unsuccessfull',
      build: () {
        when(getSearchWallpaper.call(any, any)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(More(tQuery, 1)),
      expect: () => [
        Error('Server Failure'),
      ],
      verify: (_) {
        verify(getSearchWallpaper.call(any, any));
      },
    );
  });
}
