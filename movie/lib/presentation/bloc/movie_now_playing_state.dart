part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object?> get props => [];
}

class NowPlayingEmpty extends MovieNowPlayingState {}

class NowPlayingLoading extends MovieNowPlayingState {}

class NowPlayingLoaded extends MovieNowPlayingState {
  final List<Movie> nowPlayingResult;

  NowPlayingLoaded(this.nowPlayingResult);

  @override
  List<Object?> get props => [nowPlayingResult];
}

class NowPlayingError extends MovieNowPlayingState {
  final String message;

  NowPlayingError(this.message);

  @override
  List<Object?> get props => [message];
}
