import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    tvWatchlistBloc = TvWatchlistBloc(mockGetWatchlistTvs);
  });

  test('initial state should be TvWatchlistInitial', () {
    expect(tvWatchlistBloc.state, TvWatchlistInitial());
  });

  blocTest(
    'should emit TvWatchlistLoading, TvWatchlistLoaded when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvWatchlist()),
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistLoaded(testTvList),
    ],
  );

  blocTest(
    'should emit TvWatchlistLoading, TvWatchlistError when data is failed',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvWatchlist()),
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistError('Server Failure'),
    ],
  );
}
