import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<void> cachedTvOnAir(List<TvTable> tvs);
  Future<List<TvTable>> getCacheTvOnAir();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cachedTvOnAir(List<TvTable> tvs) async {
    await databaseHelper.clearCache('on air');
    await databaseHelper.insertTvCacheTransaction(tvs, 'on air');
  }

  @override
  Future<List<TvTable>> getCacheTvOnAir() async {
    final result = await databaseHelper.getCacheMovies('on air');
    if (result.length > 0) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
