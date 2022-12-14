import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_on_air.dart';
import 'package:flutter/foundation.dart';

class OnAirTvsNotifier extends ChangeNotifier {
  final GetTvOnAir getTvOnAir;

  OnAirTvsNotifier(this.getTvOnAir);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<Tv> _tvs = [];
  List<Tv> get tvs => _tvs;

  Future<void> fetchOnAirTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnAir.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _state = RequestState.Loaded;
        _tvs = tvsData;
        notifyListeners();
      },
    );
  }
}
