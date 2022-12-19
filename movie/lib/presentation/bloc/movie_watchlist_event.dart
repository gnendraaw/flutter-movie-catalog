part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object?> get props => [];
}

class GetMovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  GetMovieWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class AddMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  AddMovieWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;

  RemoveMovieWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}
