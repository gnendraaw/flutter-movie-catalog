part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final bool isAddedWatchlist;
  final String message;

  MovieDetailLoaded(this.movieDetail, this.isAddedWatchlist, this.message);

  @override
  List<Object?> get props => [movieDetail, isAddedWatchlist, message];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieWatchlistStatusError extends MovieDetailState {
  final String message;

  MovieWatchlistStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
