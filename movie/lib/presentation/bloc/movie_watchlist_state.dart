part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object?> get props => [];
}

class MovieWatchlistStatusInitial extends MovieWatchlistState {}

class MovieWatchlistStatusLoaded extends MovieWatchlistState {
  final bool isAddedToWatchlist;
  final String message;

  MovieWatchlistStatusLoaded(
    this.isAddedToWatchlist,
    this.message,
  );

  @override
  List<Object?> get props => [isAddedToWatchlist];
}

class AddMovieWatchlistError extends MovieWatchlistState {
  final String message;

  AddMovieWatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}
