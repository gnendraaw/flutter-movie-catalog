import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tTvModel = TvModel(
      backdropPath: "/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg",
      firstAirDate: "2011-02-28",
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
      voteCount: 1471);

  final tTv = Tv(
      backdropPath: "/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg",
      firstAirDate: "2011-02-28",
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
      voteCount: 1471);

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Tv On Air', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTvOnAir()).thenAnswer((_) async => []);
      // act
      await repository.getTvOnAir();
      // assert
      verify(mockNetworkInfo.isConnected);
    });
  });
}
