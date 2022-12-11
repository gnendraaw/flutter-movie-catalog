import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks(
    [GetTvDetail, SaveWatchlistTv, GetWatchlistTvStatus, RemoveWatchlistTv])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
      getWatchlistTvStatus: mockGetWatchlistTvStatus,
    );
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

    test('should change movie when data is gotten ssuccessfully', () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvDetail(tId);

      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccess', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchTvDetail(tId);

      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
