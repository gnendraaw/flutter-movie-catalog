import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/tv.dart';

import 'tv_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationsBloc tvRecommendationsBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationsBloc = TvRecommendationsBloc(mockGetTvRecommendations);
  });

  test('initial state should be TvRecommendationsInitial', () {
    expect(tvRecommendationsBloc.state, TvRecommendationsInitial());
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
  final tId = 1;

  blocTest(
    'should emit TvRecommendationsLoading, TvRecommendationsLoaded when data is gotten successfully',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvList));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecommendations(tId)),
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(tId));
    },
    expect: () => [
      TvRecommendationsLoading(),
      TvRecommendationsLoaded(tTvList),
    ],
  );

  blocTest(
    'should emit TvRecommendationsLoading, TvRecommendationsError when data is failed',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecommendations(tId)),
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(tId));
    },
    expect: () => [
      TvRecommendationsLoading(),
      TvRecommendationsError('Server Failure'),
    ],
  );
}
