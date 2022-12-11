// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i25;
import 'dart:typed_data' as _i26;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i8;
import 'package:ditonton/common/network_info.dart' as _i24;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i22;
import 'package:ditonton/data/datasources/movie_local_data_source.dart' as _i13;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart'
    as _i11;
import 'package:ditonton/data/datasources/tv_local_data_source.dart' as _i20;
import 'package:ditonton/data/datasources/tv_remote_data_source.dart' as _i18;
import 'package:ditonton/data/models/movie_detail_model.dart' as _i3;
import 'package:ditonton/data/models/movie_model.dart' as _i12;
import 'package:ditonton/data/models/movie_table.dart' as _i14;
import 'package:ditonton/data/models/tv_detail_model.dart' as _i4;
import 'package:ditonton/data/models/tv_model.dart' as _i19;
import 'package:ditonton/data/models/tv_table.dart' as _i21;
import 'package:ditonton/domain/entities/movie.dart' as _i9;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i10;
import 'package:ditonton/domain/entities/tv.dart' as _i16;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i17;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i6;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i15;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i23;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvDetailModel_2 extends _i1.SmartFake implements _i4.TvDetailModel {
  _FakeTvDetailModel_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeStreamedResponse_4 extends _i1.SmartFake
    implements _i5.StreamedResponse {
  _FakeStreamedResponse_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                          this, Invocation.method(#getNowPlayingMovies, []))))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
              returnValue:
                  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                          this, Invocation.method(#getPopularMovies, []))))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
              returnValue:
                  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                          this, Invocation.method(#getTopRatedMovies, []))))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue:
                  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>.value(
                      _FakeEither_0<_i8.Failure, _i10.MovieDetail>(
                          this, Invocation.method(#getMovieDetail, [id]))))
          as _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i9.Movie>>(this,
                          Invocation.method(#getMovieRecommendations, [id]))))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                          this, Invocation.method(#searchMovies, [query]))))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>(
                      this, Invocation.method(#saveWatchlist, [movie]))))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>(
                      this, Invocation.method(#removeWatchlist, [movie]))))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: _i7.Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue:
                  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                          this, Invocation.method(#getWatchlistMovies, []))))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i11.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
              returnValue:
                  _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
              returnValue:
                  _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: _i7.Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1(
                      this, Invocation.method(#getMovieDetail, [id]))))
          as _i7.Future<_i3.MovieDetailResponse>);
  @override
  _i7.Future<List<_i12.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i13.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i14.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: _i7.Future<_i14.MovieTable?>.value())
          as _i7.Future<_i14.MovieTable?>);
  @override
  _i7.Future<List<_i14.MovieTable>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue:
                  _i7.Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
          as _i7.Future<List<_i14.MovieTable>>);
  @override
  _i7.Future<void> cacheNowPlayingMovies(List<_i14.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
  @override
  _i7.Future<List<_i14.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  _i7.Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
          as _i7.Future<List<_i14.MovieTable>>);
}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i15.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.Tv>>> getTvOnAir() =>
      (super.noSuchMethod(Invocation.method(#getTvOnAir, []),
          returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i16.Tv>>>.value(
              _FakeEither_0<_i8.Failure, List<_i16.Tv>>(
                  this, Invocation.method(#getTvOnAir, [])))) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i16.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i17.TvDetail>> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
          returnValue: _i7.Future<_i2.Either<_i8.Failure, _i17.TvDetail>>.value(
              _FakeEither_0<_i8.Failure, _i17.TvDetail>(
                  this, Invocation.method(#getTvDetail, [id])))) as _i7
          .Future<_i2.Either<_i8.Failure, _i17.TvDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i17.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tv]),
              returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>(
                      this, Invocation.method(#saveWatchlist, [tv]))))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: _i7.Future<bool>.value(false)) as _i7.Future<bool>);
}

/// A class which mocks [TvRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDataSource extends _i1.Mock
    implements _i18.TvRemoteDataSource {
  MockTvRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i19.TvModel>> getTvOnAir() => (super.noSuchMethod(
          Invocation.method(#getTvOnAir, []),
          returnValue: _i7.Future<List<_i19.TvModel>>.value(<_i19.TvModel>[]))
      as _i7.Future<List<_i19.TvModel>>);
  @override
  _i7.Future<_i4.TvDetailModel> getTvDetail(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvDetail, [id]),
          returnValue: _i7.Future<_i4.TvDetailModel>.value(_FakeTvDetailModel_2(
              this, Invocation.method(#getTvDetail, [id]))))
      as _i7.Future<_i4.TvDetailModel>);
}

/// A class which mocks [TvLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvLocalDataSource extends _i1.Mock implements _i20.TvLocalDataSource {
  MockTvLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<void> cachedTvOnAir(List<_i21.TvTable>? tvs) =>
      (super.noSuchMethod(Invocation.method(#cachedTvOnAir, [tvs]),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
  @override
  _i7.Future<List<_i21.TvTable>> getCacheTvOnAir() => (super.noSuchMethod(
          Invocation.method(#getCacheTvOnAir, []),
          returnValue: _i7.Future<List<_i21.TvTable>>.value(<_i21.TvTable>[]))
      as _i7.Future<List<_i21.TvTable>>);
  @override
  _i7.Future<String> insertWatchlist(_i21.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tv]),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i21.TvTable?> getTvById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvById, [id]),
              returnValue: _i7.Future<_i21.TvTable?>.value())
          as _i7.Future<_i21.TvTable?>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i22.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i23.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: _i7.Future<_i23.Database?>.value())
          as _i7.Future<_i23.Database?>);
  @override
  _i7.Future<void> insertCacheTransaction(
          List<_i14.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
              Invocation.method(#insertCacheTransaction, [movies, category]),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
  @override
  _i7.Future<void> insertTvCacheTransaction(
          List<_i21.TvTable>? tvs, String? category) =>
      (super.noSuchMethod(
              Invocation.method(#insertTvCacheTransaction, [tvs, category]),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: _i7.Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: _i7.Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertTvWatchlist(_i21.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertTvWatchlist, [tv]),
          returnValue: _i7.Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: _i7.Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeTvWatchlist(_i21.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeTvWatchlist, [tv]),
          returnValue: _i7.Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: _i7.Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvById, [id]),
              returnValue: _i7.Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTvs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvs, []),
              returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i24.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: _i7.Future<bool>.value(false)) as _i7.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this, Invocation.method(#head, [url], {#headers: headers}))))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this, Invocation.method(#get, [url], {#headers: headers}))))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#post, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this,
                  Invocation.method(#post, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#put, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this,
                  Invocation.method(#put, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#patch, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this,
                  Invocation.method(#patch, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#delete, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
                  this,
                  Invocation.method(#delete, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: _i7.Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i26.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: _i7.Future<_i26.Uint8List>.value(_i26.Uint8List(0)))
          as _i7.Future<_i26.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: _i7.Future<_i5.StreamedResponse>.value(
                  _FakeStreamedResponse_4(
                      this, Invocation.method(#send, [request]))))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
