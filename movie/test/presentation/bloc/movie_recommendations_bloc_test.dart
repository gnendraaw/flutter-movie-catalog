import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc =
        MovieRecommendationsBloc(mockGetMovieRecommendations);
  });

  test('initial state should be MovieRecommendationsInitial', () {
    expect(movieRecommendationsBloc.state, MovieRecommendationsInitial());
  });

  final tId = 1;

  blocTest(
    'should emit MovieRecommendationsLoading, MovieRecommendationsLoaded when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendations(tId)),
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
    expect: () => [
      MovieRecommendationsLoading(),
      MovieRecommendationsLoaded(testMovieList),
    ],
  );

  blocTest(
    'should emit MovieRecommendationsLoading, MovieRecommendationsError when data is failed',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendations(tId)),
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
    expect: () => [
      MovieRecommendationsLoading(),
      MovieRecommendationsError('Server Failure'),
    ],
  );
}
