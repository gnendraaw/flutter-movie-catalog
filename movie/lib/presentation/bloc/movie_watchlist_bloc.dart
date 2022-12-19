import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/movie.dart';

part 'movie_watchlist_state.dart';
part 'movie_watchlist_event.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final GetWatchlistMovies getWatchlistMovies;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWatchlistBloc({
    required this.getWatchListStatus,
    required this.getWatchlistMovies,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieWatchlistStatusInitial()) {
    on<GetMovieWatchlistStatus>(
      (event, emit) async {
        final result = await getWatchListStatus.execute(event.id);
        emit(MovieWatchlistStatusLoaded(result, ''));
      },
    );

    on<AddMovieWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(AddMovieWatchlistError(failure.message));
        },
        (data) {
          emit(MovieWatchlistStatusLoaded(true, data));
        },
      );
    });

    on<RemoveMovieWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(AddMovieWatchlistError(failure.message));
        },
        (data) {
          emit(MovieWatchlistStatusLoaded(false, data));
        },
      );
    });
  }
}
