// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/pages/tv_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:ui' as _i9;

import 'package:ditonton/common/state_enum.dart' as _i7;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i5;
import 'package:ditonton/domain/usecases/get_tv_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/get_watchlist_status.dart' as _i3;
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart' as _i4;
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeGetTvDetail_0 extends _i1.SmartFake implements _i2.GetTvDetail {
  _FakeGetTvDetail_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetWatchListStatus_1 extends _i1.SmartFake
    implements _i3.GetWatchListStatus {
  _FakeGetWatchListStatus_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSaveWatchlistTv_2 extends _i1.SmartFake
    implements _i4.SaveWatchlistTv {
  _FakeSaveWatchlistTv_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvDetail_3 extends _i1.SmartFake implements _i5.TvDetail {
  _FakeTvDetail_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TvDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailNotifier extends _i1.Mock implements _i6.TvDetailNotifier {
  MockTvDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetail get getTvDetail =>
      (super.noSuchMethod(Invocation.getter(#getTvDetail),
              returnValue:
                  _FakeGetTvDetail_0(this, Invocation.getter(#getTvDetail)))
          as _i2.GetTvDetail);
  @override
  _i3.GetWatchListStatus get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
              returnValue: _FakeGetWatchListStatus_1(
                  this, Invocation.getter(#getWatchListStatus)))
          as _i3.GetWatchListStatus);
  @override
  _i4.SaveWatchlistTv get saveWatchlistTv => (super.noSuchMethod(
          Invocation.getter(#saveWatchlistTv),
          returnValue:
              _FakeSaveWatchlistTv_2(this, Invocation.getter(#saveWatchlistTv)))
      as _i4.SaveWatchlistTv);
  @override
  _i5.TvDetail get tv => (super.noSuchMethod(Invocation.getter(#tv),
          returnValue: _FakeTvDetail_3(this, Invocation.getter(#tv)))
      as _i5.TvDetail);
  @override
  _i7.RequestState get tvState =>
      (super.noSuchMethod(Invocation.getter(#tvState),
          returnValue: _i7.RequestState.Empty) as _i7.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatclist =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatclist),
          returnValue: false) as bool);
  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i8.Future<void> fetchTvDetail(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchTvDetail, [id]),
      returnValue: _i8.Future<void>.value(),
      returnValueForMissingStub: _i8.Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> addWatchlist(_i5.TvDetail? tv) => (super.noSuchMethod(
      Invocation.method(#addWatchlist, [tv]),
      returnValue: _i8.Future<void>.value(),
      returnValueForMissingStub: _i8.Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> loadWatchlistStatus(int? id) => (super.noSuchMethod(
      Invocation.method(#loadWatchlistStatus, [id]),
      returnValue: _i8.Future<void>.value(),
      returnValueForMissingStub: _i8.Future<void>.value()) as _i8.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
