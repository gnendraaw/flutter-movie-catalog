import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
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

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvOnAir())
            .thenAnswer((_) async => tTvModelList);

        // act
        final result = await repository.getTvOnAir();

        // assert
        verify(mockRemoteDataSource.getTvOnAir());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvOnAir())
            .thenAnswer((_) async => tTvModelList);

        // act
        final result = await repository.getTvOnAir();

        // assert
        verify(mockRemoteDataSource.getTvOnAir());
        verify(mockLocalDataSource.cachedTvOnAir([testTvCache]));
      });

      test(
          'should return server failure when call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvOnAir()).thenThrow(ServerException());

        // act
        final result = await repository.getTvOnAir();

        // assert
        verify(mockRemoteDataSource.getTvOnAir());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cache data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCacheTvOnAir())
            .thenAnswer((_) async => [testTvCache]);

        // act
        final result = await repository.getTvOnAir();

        // assert
        verify(mockLocalDataSource.getCacheTvOnAir());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCacheTvOnAir())
            .thenThrow(CacheException('No Cache'));

        // act
        final result = await repository.getTvOnAir();

        // assert
        verify(mockLocalDataSource.getCacheTvOnAir());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });
}
