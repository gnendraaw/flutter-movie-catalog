part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusEvent extends Equatable {
  const MovieWatchlistStatusEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovieWatchlistStatus extends MovieWatchlistStatusEvent {
  final int id;

  LoadMovieWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class SaveMovieWatchlist extends MovieWatchlistStatusEvent {
  final MovieDetail movie;

  SaveMovieWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveMovieWatchlist extends MovieWatchlistStatusEvent {
  final MovieDetail movie;

  RemoveMovieWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}
