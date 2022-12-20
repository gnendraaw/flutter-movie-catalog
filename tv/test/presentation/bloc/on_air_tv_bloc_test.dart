import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_on_air.dart';
import 'package:tv/presentation/bloc/on_air_tv_bloc.dart';

import 'on_air_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvOnAir])
void main() {
  late OnAirTvBloc onAirTvBloc;
  late MockGetTvOnAir mockGetTvOnAir;

  setUp(() {
    mockGetTvOnAir = MockGetTvOnAir();
    onAirTvBloc = OnAirTvBloc(mockGetTvOnAir);
  });

  test('initial state should be OnAirTvInitial', () {
    expect(onAirTvBloc.state, OnAirTvInitial());
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
    'should emit OnAirTvLoading, OnAirTvLoaded when data is gotten successfully',
    build: () {
      when(mockGetTvOnAir.execute()).thenAnswer((_) async => Right(tTvList));
      return onAirTvBloc;
    },
    act: (bloc) => bloc.add(FetchOnAirTv()),
    verify: (bloc) {
      verify(mockGetTvOnAir.execute());
    },
    expect: () => [
      OnAirTvLoading(),
      OnAirTvLoaded(tTvList),
    ],
  );

  blocTest(
    'should emit OnAirTvLoading, OnAirTvError when data is failed',
    build: () {
      when(mockGetTvOnAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return onAirTvBloc;
    },
    act: (bloc) => bloc.add(FetchOnAirTv()),
    verify: (bloc) {
      verify(mockGetTvOnAir.execute());
    },
    expect: () => [
      OnAirTvLoading(),
      OnAirTvError('Server Failure'),
    ],
  );
}
