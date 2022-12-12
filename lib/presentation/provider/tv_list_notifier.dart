import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_tv_on_air.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _tvOnAir = <Tv>[];
  List<Tv> get tvOnAir => _tvOnAir;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  RequestState _popularTvsState = RequestState.Empty;
  RequestState get popularTvsState => _popularTvsState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getTvOnAir,
    required this.getPopularTvs,
  });

  final GetTvOnAir getTvOnAir;
  final GetPopularTvs getPopularTvs;

  Future<void> fetchTvOnAir() async {
    _onAirState = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnAir.execute();
    result.fold(
      (failure) {
        _onAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _onAirState = RequestState.Loaded;
        _tvOnAir = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvs() async {
    _popularTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        _popularTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularTvsState = RequestState.Loaded;
        _popularTvs = tvsData;
        notifyListeners();
      },
    );
  }
}
