import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:tv/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<void> cachedTvOnAir(List<TvTable> tvs);
  Future<List<TvTable>> getCacheTvOnAir();
  Future<String> insertWatchlist(TvTable tv);
  Future<String> removeWatchlist(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTvs();
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

  @override
  Future<String> insertWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertTvWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable tv) async {
    try {
      await databaseHelper.removeTvWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvs() async {
    final result = await databaseHelper.getWatchlistTvs();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
