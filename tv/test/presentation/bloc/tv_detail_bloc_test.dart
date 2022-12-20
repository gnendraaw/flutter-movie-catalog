import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  test('initial state should be TvDetailInitial', () {
    expect(tvDetailBloc.state, TvDetailInitial());
  });

  final testTvDetail = TvDetail(
    adult: false,
    backdropPath: '/path.jpg',
    genres: [Genre(id: 1, name: 'Name')],
    id: 1,
    name: 'Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tId = 1;

  blocTest(
    'should emit TvDetailLoading, TvDetailLoaded when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(tId)),
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    },
    expect: () => [
      TvDetailLoading(),
      TvDetailLoaded(testTvDetail),
    ],
  );

  blocTest(
    'should emit TvDetailLoading, TvDetailError when data is failed',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(tId)),
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    },
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
  );
}
