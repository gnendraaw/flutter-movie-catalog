part of 'movie_watchlist_status_bloc.dart';

class MovieWatchlistStatusEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovieWatchlistStatus extends MovieWatchlistStatusEvent {
  final int id;

  GetMovieWatchlistStatus(this.id);

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
