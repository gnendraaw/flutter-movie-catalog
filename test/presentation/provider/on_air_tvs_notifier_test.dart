import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_on_air.dart';
import 'package:core/presentation/provider/on_air_tvs_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'on_air_tvs_notifier_test.mocks.dart';

@GenerateMocks([GetTvOnAir])
void main() {
  late MockGetTvOnAir mockGetTvOnAir;
  late OnAirTvsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvOnAir = MockGetTvOnAir();
    notifier = OnAirTvsNotifier(mockGetTvOnAir)
      ..addListener(() {
        listenerCallCount++;
      });
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvOnAir.execute()).thenAnswer((_) async => Right(tTvList));

    // act
    notifier.fetchOnAirTvs();

    //assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvOnAir.execute()).thenAnswer((_) async => Right(tTvList));

    // act
    await notifier.fetchOnAirTvs();

    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is failed', () async {
    // arrange
    when(mockGetTvOnAir.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    // act
    await notifier.fetchOnAirTvs();

    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
