import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv_watchlist_status_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvStatus, SaveWatchlistTv, RemoveWatchlistTv])
void main() {
  late TvWatchlistStatusBloc tvWatchlistStatusBloc;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    tvWatchlistStatusBloc = TvWatchlistStatusBloc(
      mockGetWatchlistTvStatus,
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
    );
  });

  test('initial state should be TvWatchlistStatusInitial', () {
    expect(tvWatchlistStatusBloc.state, TvWatchlistStatusInitial());
  });

  final tId = 1;

  blocTest(
    'should emit TvWatchlistStatusLoaded when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvStatus.execute(tId)).thenAnswer((_) async => true);
      return tvWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistTvStatus(tId)),
    verify: (bloc) {
      verify(mockGetWatchlistTvStatus.execute(tId));
    },
    expect: () => [
      TvWatchlistStatusLoaded(true),
    ],
  );

  blocTest(
    'should emit TvWatchlistStatusLoaded when SaveTvWatchlist success',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      return tvWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(SaveTvWatchlist(testTvDetail)),
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
    expect: () => [
      TvWatchlistStatusLoaded(true),
    ],
  );

  blocTest(
    'should emit TvWatchlistStatusError when failed to insert or remove watchlist',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(SaveTvWatchlist(testTvDetail)),
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    },
    expect: () => [
      TvWatchlistStatusError('Server Failure'),
    ],
  );
}
