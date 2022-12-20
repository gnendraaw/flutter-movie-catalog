import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

part 'movie_watchlist_state.dart';
part 'movie_watchlist_event.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistBloc(this.getWatchlistMovies) : super(MovieWatchlistInitial()) {
    on<FetchMovieWatchlist>(
      (event, emit) async {
        emit(MovieWatchlistLoading());
        final result = await getWatchlistMovies.execute();

        result.fold(
          (failure) {
            emit(MovieWatchlistError(failure.message));
          },
          (data) {
            emit(MovieWatchlistLoaded(data));
          },
        );
      },
    );
  }
}
