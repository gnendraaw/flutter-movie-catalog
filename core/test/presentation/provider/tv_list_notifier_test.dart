import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tvs.dart';
import 'package:core/domain/usecases/get_top_rated_tvs.dart';
import 'package:core/domain/usecases/get_tv_on_air.dart';
import 'package:core/presentation/provider/tv_list_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'on_air_tvs_notifier_test.mocks.dart';
import 'popular_tvs_notifier_test.mocks.dart';
import 'top_rated_tvs_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvOnAir,
  GetPopularTvs,
  GetTopRatedTvs,
])
void main() {
  late TvListNotifier provider;
  late MockGetTvOnAir mockGetTvOnAir;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvOnAir = MockGetTvOnAir();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    provider = TvListNotifier(
      getTvOnAir: mockGetTvOnAir,
      getPopularTvs: mockGetPopularTvs,
      getTopRatedTvs: mockGetTopRatedTvs,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = Tv(
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: 'Name',
    originCountry: ['Country'],
    originalLanguage: 'Language',
    originalName: 'Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  group('tv on air', () {
    test('initialState should be Empty', () async {
      expect(provider.onAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvOnAir.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      provider.fetchTvOnAir();

      // assert
      verify(mockGetTvOnAir.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvOnAir.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      provider.fetchTvOnAir();

      // assert
      expect(provider.onAirState, RequestState.Loading);
    });

    test('should change tvs when data gotten successfully', () async {
      // arrange
      when(mockGetTvOnAir.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      await provider.fetchTvOnAir();

      // assert
      expect(provider.onAirState, RequestState.Loaded);
      expect(provider.tvOnAir, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvOnAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchTvOnAir();

      // assert
      expect(provider.onAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      provider.fetchPopularTvs();

      // assert
      expect(provider.popularTvsState, RequestState.Loading);
    });

    test('should change tvs data when data is goten successfully', () async {
      // arrange
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      await provider.fetchPopularTvs();

      // assert
      expect(provider.popularTvsState, RequestState.Loaded);
      expect(provider.popularTvs, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is failed', () async {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchPopularTvs();

      // assert
      expect(provider.popularTvsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));

      // act
      provider.fetchTopRatedTvs();

      // assert
      expect(provider.topRatedState, RequestState.Loading);
    });
  });

  test('should change tvs data when data is goten successfully', () async {
    // arrange
    when(mockGetTopRatedTvs.execute()).thenAnswer((_) async => Right(tTvList));

    // act
    await provider.fetchTopRatedTvs();

    // assert
    expect(provider.topRatedState, RequestState.Loaded);
    expect(provider.topRatedTvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is failed', () async {
    // arrange
    when(mockGetTopRatedTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    // act
    await provider.fetchTopRatedTvs();

    // assert
    expect(provider.topRatedState, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
