import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/movie.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWatchlistStatusBloc(
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(MovieWatchlistStatusInitial()) {
    on<LoadMovieWatchlistStatus>(
      (event, emit) async {
        final result = await getWatchListStatus.execute(event.id);
        emit(MovieWatchlistStatusLoaded(result));
      },
    );

    on<SaveMovieWatchlist>(
      (event, emit) async {
        final result = await saveWatchlist.execute(event.movie);
        result.fold(
          (failure) {
            emit(MovieWatchlistStatusError(failure.message));
          },
          (data) {
            emit(MovieWatchlistStatusLoaded(true));
          },
        );
      },
    );

    on<RemoveMovieWatchlist>(
      (event, emit) async {
        final result = await removeWatchlist.execute(event.movie);
        result.fold(
          (failure) {
            emit(MovieWatchlistStatusError(failure.message));
          },
          (data) {
            emit(MovieWatchlistStatusLoaded(false));
          },
        );
      },
    );
  }
}
