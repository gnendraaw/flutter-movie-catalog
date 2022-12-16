import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/search_tvs.dart';
import 'package:core/presentation/provider/tv_search_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late TvSearchNotifier provider;
  late MockSearchTvs mockSearchTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvs = MockSearchTvs();
    provider = TvSearchNotifier(mockSearchTvs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvModel = Tv(
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
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'halo';

  group('search tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));

      // act
      provider.fetchSearchTvs(tQuery);

      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));

      // act
      await provider.fetchSearchTvs(tQuery);

      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is failed', () async {
      // arrange
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchSearchTvs(tQuery);

      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
