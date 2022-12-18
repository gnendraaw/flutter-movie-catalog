part of 'movie_now_playing_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object?> get props => [];
}

class FetchNowPlayingMovies extends MovieListEvent {
  const FetchNowPlayingMovies();

  @override
  List<Object?> get props => [];
}
