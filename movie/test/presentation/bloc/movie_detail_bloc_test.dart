import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  test('initial state should be MovieDetailInitial', () {
    expect(movieDetailBloc.state, MovieDetailInitial());
  });

  final tId = 1;

  blocTest(
    'should emit MovieDetailLoading, MovieDetailLoaded when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(tId)),
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
    expect: () => [
      MovieDetailLoading(),
      MovieDetailLoaded(testMovieDetail),
    ],
  );

  blocTest(
    'should emit MovieDetailLoading, MovieDetailError when data is failed',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(tId)),
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Server Failure'),
    ],
  );
}
