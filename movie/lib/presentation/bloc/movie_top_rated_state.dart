part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object?> get props => [];
}

class MovieTopRatedEmpty extends MovieTopRatedState {}

class MovieTopRatedLoading extends MovieTopRatedState {}

class MovieTopRatedLoaded extends MovieTopRatedState {
  final List<Movie> result;

  MovieTopRatedLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  MovieTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}
