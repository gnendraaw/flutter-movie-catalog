import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieWatchlistStatusBloc movieWatchlistStatusBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistStatusBloc = MovieWatchlistStatusBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  test('initial state should be MovieWatchlistStatusInitial', () {
    expect(movieWatchlistStatusBloc.state, MovieWatchlistStatusInitial());
  });

  final tId = 1;

  blocTest(
    'should emit MovieWatchlistStatusLoaded when data is gotten successfully',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return movieWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(LoadMovieWatchlistStatus(tId)),
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
    expect: () => [
      MovieWatchlistStatusLoaded(true),
    ],
  );

  blocTest(
    'should emit MovieWatchlistStatusLoaded when SaveMovieWatchlist success',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      return movieWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(SaveMovieWatchlist(testMovieDetail)),
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
    expect: () => [
      MovieWatchlistStatusLoaded(true),
    ],
  );

  blocTest(
    'should emit MovieWatchlistStatusError when failed to insert or remove watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(SaveMovieWatchlist(testMovieDetail)),
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
    expect: () => [
      MovieWatchlistStatusError('Server Failure'),
    ],
  );
}
