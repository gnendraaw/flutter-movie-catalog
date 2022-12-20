import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvBloc = PopularTvBloc(mockGetPopularTvs);
  });

  test('initial state should be PopularTvInitial', () {
    expect(popularTvBloc.state, PopularTvInitial());
  });

  final tTv = Tv(
    backdropPath: "/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg",
    genreIds: [18, 80],
    id: 31586,
    name: "La Reina del Sur",
    originCountry: ["US"],
    originalLanguage: "es",
    originalName: "La Reina del Sur",
    overview:
        "After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...",
    popularity: 1476.202,
    posterPath: "/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg",
    voteAverage: 7.8,
    voteCount: 1471,
  );
  final tTvList = <Tv>[tTv];

  blocTest(
    'should emit PopularTvLoading, OnAirTvLoaded when data is gotten successfully',
    build: () {
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
    expect: () => [
      PopularTvLoading(),
      PopularTvLoaded(tTvList),
    ],
  );

  blocTest(
    'should emit PopularTvLoading, OnAirTvError when data is failed',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
    expect: () => [
      PopularTvLoading(),
      PopularTvError('Server Failure'),
    ],
  );
}
