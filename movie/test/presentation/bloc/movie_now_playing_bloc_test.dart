import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';

import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MovieNowPlayingBloc nowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingBloc =
        MovieNowPlayingBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  test('initial state should be NowPlayingEmpty', () {
    expect(nowPlayingBloc.state, NowPlayingEmpty());
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

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
    expect: () => [
      NowPlayingLoading(),
      NowPlayingLoaded(tMovieList),
    ],
  );

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should emit [Loading, Error] when data failed',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
    expect: () => [
      NowPlayingLoading(),
      NowPlayingError('Server Failure'),
    ],
  );
}
