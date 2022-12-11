import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('cache tv on air', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('on air')).thenAnswer((_) async => 1);

      // act
      await dataSource.cachedTvOnAir([testTvCache]);

      // assert
      verify(mockDatabaseHelper.clearCache('on air'));
      verify(
          mockDatabaseHelper.insertTvCacheTransaction([testTvCache], 'on air'));
    });
  });

  group('Get Tv Detail by Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);

      // act
      final result = await dataSource.getTvById(tId);

      // assert
      expect(result, testTvTable);
    });
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.insertWatchlist(testTvTable);

      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
          .thenThrow(Exception());

      // act
      final call = dataSource.insertWatchlist(testTvTable);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.removeWatchlist(testTvTable);

      // assert
      expect(result, 'Removed from Watchlist');
    });
  });
}
