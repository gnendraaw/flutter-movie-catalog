import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_tv_on_air.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvOnAir, GetPopularTvs])
void main() {
  late TvListNotifier provider;
  late MockGetTvOnAir mockGetTvOnAir;
  late MockGetPopularTvs mockGetPopularTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvOnAir = MockGetTvOnAir();
    mockGetPopularTvs = MockGetPopularTvs();
    provider = TvListNotifier(
      getTvOnAir: mockGetTvOnAir,
      getPopularTvs: mockGetPopularTvs,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = Tv(
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    firstAirDate: '1111-11-11',
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
}
