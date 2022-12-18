import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(MoviePopularEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MoviePopularLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(MoviePopularError(failure.message));
        },
        (data) {
          emit(MoviePopularLoaded(data));
        },
      );
    });
  }
}
