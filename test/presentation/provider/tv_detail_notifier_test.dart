import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  SaveWatchlistTv,
  GetWatchlistTvStatus,
  RemoveWatchlistTv
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
      getWatchlistTvStatus: mockGetWatchlistTvStatus,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

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
  final tTvs = <Tv>[tTv];

  void _arrangeUseCase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvs));
  }

  group('Get Tv Detail', () {
    test('should get data from useCase', () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvDetail(tId);

      // assert
      verify(mockGetTvDetail.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUseCase();

      // act
      provider.fetchTvDetail(tId);

      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvDetail(tId);

      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tvs when data is gotten successfully',
        () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvDetail(tId);

      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvs);
    });
  });

  group('Get Tvs Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvDetail(tId);

      // assert
      verify(mockGetTvRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTvs);
    });

    test('should update recommendation state when data is gotten successfuly',
        () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvDetail(tId);

      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvs);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      // act
      await provider.fetchTvDetail(tId);

      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistTvStatus.execute(1)).thenAnswer((_) async => true);

      // act
      await provider.loadWatchlistStatus(1);

      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);

      // act
      await provider.addWatchlist(testTvDetail);

      // assert
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);

      // act
      await provider.removeFromWatchList(testTvDetail);

      // assert
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);

      // act
      await provider.addWatchlist(testTvDetail);

      // assert
      verify(mockGetWatchlistTvStatus.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);

      // act
      await provider.addWatchlist(testTvDetail);

      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvs));

      // act
      await provider.fetchTvDetail(tId);

      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
