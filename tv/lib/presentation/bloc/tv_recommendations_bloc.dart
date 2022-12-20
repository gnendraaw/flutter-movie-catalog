import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTvRecommendations getTvRecommendations;

  TvRecommendationsBloc(this.getTvRecommendations)
      : super(TvRecommendationsInitial()) {
    on<FetchTvRecommendations>(
      (event, emit) async {
        emit(TvRecommendationsLoading());
        final result = await getTvRecommendations.execute(event.id);

        result.fold(
          (failure) {
            emit(TvRecommendationsError(failure.message));
          },
          (data) {
            emit(TvRecommendationsLoaded(data));
          },
        );
      },
    );
  }
}
