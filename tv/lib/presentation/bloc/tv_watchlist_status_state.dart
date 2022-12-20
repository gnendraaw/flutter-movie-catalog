part of 'tv_watchlist_status_bloc.dart';

abstract class TvWatchlistStatusState extends Equatable {
  const TvWatchlistStatusState();

  @override
  List<Object?> get props => [];
}

class TvWatchlistStatusInitial extends TvWatchlistStatusState {}

class TvWatchlistStatusLoaded extends TvWatchlistStatusState {
  final bool isAddedWatchlist;

  TvWatchlistStatusLoaded(this.isAddedWatchlist);

  @override
  List<Object?> get props => [isAddedWatchlist];
}

class TvWatchlistStatusError extends TvWatchlistStatusState {
  final String message;

  TvWatchlistStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
