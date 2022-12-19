part of 'movie_watchlist_status_bloc.dart';

class MovieWatchlistStatusState extends Equatable {
  final bool isAddedWatchlist;
  final String message;
  final RequestState requestState;

  static const successAddWatchlistMsg = 'Added to Watchlist';
  static const successRemoveWatchlistMsg = 'Removed from Watchlist';

  MovieWatchlistStatusState({
    this.isAddedWatchlist = false,
    this.message = '',
    this.requestState = RequestState.Empty,
  });

  @override
  List<Object?> get props => [isAddedWatchlist, message, requestState];
}
