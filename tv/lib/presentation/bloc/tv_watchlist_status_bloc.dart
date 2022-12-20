import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

part 'tv_watchlist_status_event.dart';
part 'tv_watchlist_status_state.dart';

class TvWatchlistStatusBloc
    extends Bloc<TvWatchlistStatusEvent, TvWatchlistStatusState> {
  final GetWatchlistTvStatus getWatchlistTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvWatchlistStatusBloc(
      this.getWatchlistTvStatus, this.saveWatchlistTv, this.removeWatchlistTv)
      : super(TvWatchlistStatusInitial()) {
    on<LoadWatchlistTvStatus>(
      (event, emit) async {
        final result = await getWatchlistTvStatus.execute(event.id);
        emit(TvWatchlistStatusLoaded(result));
      },
    );

    on<SaveTvWatchlist>(
      (event, emit) async {
        final result = await saveWatchlistTv.execute(event.tv);
        result.fold(
          (failure) {
            emit(TvWatchlistStatusError(failure.message));
          },
          (data) {
            emit(TvWatchlistStatusLoaded(true));
          },
        );
      },
    );

    on<RemoveTvWatchlist>(
      (event, emit) async {
        final result = await removeWatchlistTv.execute(event.tv);
        result.fold(
          (failure) {
            emit(TvWatchlistStatusError(failure.message));
          },
          (data) {
            emit(TvWatchlistStatusLoaded(false));
          },
        );
      },
    );
  }
}
