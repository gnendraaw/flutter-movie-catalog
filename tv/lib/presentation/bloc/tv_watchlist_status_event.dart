part of 'tv_watchlist_status_bloc.dart';

abstract class TvWatchlistStatusEvent extends Equatable {
  const TvWatchlistStatusEvent();

  @override
  List<Object?> get props => [];
}

class LoadWatchlistTvStatus extends TvWatchlistStatusEvent {
  final int id;

  const LoadWatchlistTvStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class SaveTvWatchlist extends TvWatchlistStatusEvent {
  final TvDetail tv;

  SaveTvWatchlist(this.tv);

  @override
  List<Object?> get props => [tv];
}

class RemoveTvWatchlist extends TvWatchlistStatusEvent {
  final TvDetail tv;

  RemoveTvWatchlist(this.tv);

  @override
  List<Object?> get props => [tv];
}
