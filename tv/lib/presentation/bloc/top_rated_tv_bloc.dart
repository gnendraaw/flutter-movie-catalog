import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvBloc(this.getTopRatedTvs) : super(TopRatedTvInitial()) {
    on<FetchTopRatedTv>(
      (event, emit) async {
        emit(TopRatedTvLoading());
        final result = await getTopRatedTvs.execute();

        result.fold(
          (failure) {
            emit(TopRatedTvError(failure.message));
          },
          (data) {
            emit(TopRatedTvLoaded(data));
          },
        );
      },
    );
  }
}
