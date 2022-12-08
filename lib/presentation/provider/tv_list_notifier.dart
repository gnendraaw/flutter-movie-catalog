import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_on_air.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _tvOnAir = <Tv>[];
  List<Tv> get tvOnAir => _tvOnAir;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getTvOnAir,
  });

  final GetTvOnAir getTvOnAir;

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
}
