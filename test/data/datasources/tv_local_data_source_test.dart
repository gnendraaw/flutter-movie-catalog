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
}
