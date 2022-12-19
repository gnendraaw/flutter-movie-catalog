import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWatchlistStatusBloc(
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MovieWatchlistStatusState()) {
    on<GetMovieWatchlistStatus>(
      (event, emit) async {
        final result = await getWatchListStatus.execute(event.id);
        emit(MovieWatchlistStatusState(isAddedWatchlist: result));
      },
    );

    on<SaveMovieWatchlist>(
      (event, emit) async {
        emit(MovieWatchlistStatusState(requestState: RequestState.Loading));
        final result = await saveWatchlist.execute(event.movie);

        result.fold(
          (failure) {
            emit(MovieWatchlistStatusState(requestState: RequestState.Error));
          },
          (data) {
            emit(MovieWatchlistStatusState(
              isAddedWatchlist: true,
              message: data,
              requestState: RequestState.Loaded,
            ));
          },
        );
      },
    );

    on<RemoveMovieWatchlist>(
      (event, emit) async {
        emit(MovieWatchlistStatusState(requestState: RequestState.Loading));
        final result = await removeWatchlist.execute(event.movie);

        result.fold(
          (failure) {
            emit(MovieWatchlistStatusState(requestState: RequestState.Error));
          },
          (data) {
            emit(MovieWatchlistStatusState(
              isAddedWatchlist: false,
              message: data,
              requestState: RequestState.Loaded,
            ));
          },
        );
      },
    );
  }
}
