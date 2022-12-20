import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:search/domain/usecase/search_tvs.dart';
import 'package:search/presentation/bloc/tv_search_bloc.dart';
import 'package:tv/domain/entities/tv.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    tvSearchBloc = TvSearchBloc(mockSearchTvs);
  });

  test('initial state should be TvSearchInitial', () {
    expect(tvSearchBloc.state, TvSearchInitial());
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
  final tQuery = 'upin ipin';

  blocTest<TvSearchBloc, TvSearchState>(
      'should emit TvSearchLoading, TvSearchLoaded when data is gotten successfully',
      build: () {
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(QueryTv(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            TvSearchLoading(),
            TvSearchLoaded(tTvList),
          ],
      verify: (bloc) {
        verify(mockSearchTvs.execute(tQuery));
      });

  blocTest<TvSearchBloc, TvSearchState>(
      'should emit TvSearchLoading, TvSearchError when data is failed',
      build: () {
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(QueryTv(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            TvSearchLoading(),
            TvSearchError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchTvs.execute(tQuery));
      });
}
