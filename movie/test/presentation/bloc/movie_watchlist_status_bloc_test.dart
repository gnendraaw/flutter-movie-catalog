import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

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
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state should be MovieWatchlistStatus()', () {
    expect(movieWatchlistStatusBloc.state, MovieWatchlistStatusState());
  });

  final tId = 1;

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should emit isAddedWatchlist status when GetMovieWatchlistStatus event happened',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return movieWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(GetMovieWatchlistStatus(tId)),
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
    expect: () => [
      MovieWatchlistStatusState(isAddedWatchlist: true),
    ],
  );
}
