import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';

import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviePopularBloc popularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  test('initial state should be PopularEmpty', () {
    expect(popularBloc.state, MoviePopularEmpty());
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

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
    expect: () => [
      MoviePopularLoading(),
      MoviePopularLoaded(tMovieList),
    ],
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit [Loading, Error] when data failed',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
    expect: () => [
      MoviePopularLoading(),
      MoviePopularError('Server Failure'),
    ],
  );
}
