import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';

import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieWatchlistBloc = MovieWatchlistBloc(mockGetWatchlistMovies);
  });

  test('initial state should be MovieWatchlistInitial', () {
    expect(movieWatchlistBloc.state, MovieWatchlistInitial());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchMovieWatchlist()),
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistLoaded(tMovieList),
    ],
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should emit [Loading, Error] when data failed',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchMovieWatchlist()),
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistError('Server Failure'),
    ],
  );
}
