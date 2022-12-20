import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_on_air.dart';

part 'on_air_tv_event.dart';
part 'on_air_tv_state.dart';

class OnAirTvBloc extends Bloc<OnAirTvEvent, OnAirTvState> {
  final GetTvOnAir getTvOnAir;

  OnAirTvBloc(this.getTvOnAir) : super(OnAirTvInitial()) {
    on<FetchOnAirTv>(
      (event, emit) async {
        emit(OnAirTvLoading());
        final result = await getTvOnAir.execute();

        result.fold(
          (failure) {
            emit(OnAirTvError(failure.message));
          },
          (data) {
            emit(OnAirTvLoaded(data));
          },
        );
      },
    );
  }
}
