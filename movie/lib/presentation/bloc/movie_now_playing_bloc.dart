import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc extends Bloc<MovieListEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieNowPlayingBloc({
    required this.getNowPlayingMovies,
  }) : super(NowPlayingEmpty()) {
    on<FetchNowPlayingMovies>(
      (event, emit) async {
        emit(NowPlayingLoading());
        final result = await getNowPlayingMovies.execute();

        result.fold(
          (failure) {
            emit(NowPlayingError(failure.message));
          },
          (data) {
            emit(NowPlayingLoaded(data));
          },
        );
      },
    );
  }
}
