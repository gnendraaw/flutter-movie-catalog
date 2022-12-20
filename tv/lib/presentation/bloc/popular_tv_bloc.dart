import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvs getPopularTvs;

  PopularTvBloc(this.getPopularTvs) : super(PopularTvInitial()) {
    on<FetchPopularTv>(
      (event, emit) async {
        emit(PopularTvLoading());
        final result = await getPopularTvs.execute();

        result.fold(
          (failure) {
            emit(PopularTvError(failure.message));
          },
          (data) {
            emit(PopularTvLoaded(data));
          },
        );
      },
    );
  }
}
