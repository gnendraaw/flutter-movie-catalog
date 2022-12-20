import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tvs.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTvs getWatchlistTvs;

  TvWatchlistBloc(this.getWatchlistTvs) : super(TvWatchlistInitial()) {
    on<FetchTvWatchlist>(
      (event, emit) async {
        emit(TvWatchlistLoading());
        final result = await getWatchlistTvs.execute();

        result.fold(
          (failure) {
            emit(TvWatchlistError(failure.message));
          },
          (data) {
            emit(TvWatchlistLoaded(data));
          },
        );
      },
    );
  }
}
