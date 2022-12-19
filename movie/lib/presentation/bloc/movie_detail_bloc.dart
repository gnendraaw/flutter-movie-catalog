import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  }) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>(
      (event, emit) async {
        emit(MovieDetailLoading());
        final result = await getMovieDetail.execute(event.id);

        result.fold(
          (failure) {
            emit(MovieDetailError(failure.message));
          },
          (data) {
            emit(MovieDetailLoaded(data));
          },
        );
      },
    );
  }
}
