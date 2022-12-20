part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusState extends Equatable {
  const MovieWatchlistStatusState();

  @override
  List<Object?> get props => [];
}

class MovieWatchlistStatusInitial extends MovieWatchlistStatusState {}

class MovieWatchlistStatusLoaded extends MovieWatchlistStatusState {
  final bool isAddedWatchlist;

  MovieWatchlistStatusLoaded(this.isAddedWatchlist);

  @override
  List<Object?> get props => [isAddedWatchlist];
}

class MovieWatchlistStatusError extends MovieWatchlistStatusState {
  final String message;

  MovieWatchlistStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
