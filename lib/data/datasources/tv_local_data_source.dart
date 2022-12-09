import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<void> cachedTvOnAir(List<TvTable> tvs);
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cachedTvOnAir(List<TvTable> tvs) async {
    await databaseHelper.clearCache('on air');
    await databaseHelper.insertTvCacheTransaction(tvs, 'on air');
  }
}
