import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  late MovieDetail movie;

  MovieDetailBloc(
    this.getMovieDetail,
    this.saveWatchlist,
    this.removeWatchlist,
    this.getWatchListStatus,
  ) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>(
      (event, emit) async {
        emit(MovieDetailLoading());
        final result = await getMovieDetail.execute(event.id);
        final watchlistStatus = await getWatchListStatus.execute(event.id);
        final message =
            watchlistStatus ? 'Removed from Watchlist' : 'Added to Watchlist';

        result.fold(
          (failure) {
            emit(MovieDetailError(failure.message));
          },
          (data) {
            movie = data;
            emit(MovieDetailLoaded(
              movie,
              watchlistStatus,
              message,
            ));
          },
        );
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
            emit(MovieDetailLoaded(movie, true, 'Removed from Watchlist'));
          },
        );
      },
    );

    on<RemoveMovieWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(MovieWatchlistStatusError(failure.message));
        },
        (data) {
          emit(MovieDetailLoaded(movie, false, 'Added to Watchlist'));
        },
      );
    });
  }
}
