import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecase/search_tvs.dart';
import 'package:tv/domain/entities/tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs searchTvs;

  TvSearchBloc(this.searchTvs) : super(TvSearchInitial()) {
    on<QueryTv>(
      (event, emit) async {
        emit(TvSearchLoading());
        final result = await searchTvs.execute(event.query);

        result.fold(
          (failure) {
            emit(TvSearchError(failure.message));
          },
          (data) {
            emit(TvSearchLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
