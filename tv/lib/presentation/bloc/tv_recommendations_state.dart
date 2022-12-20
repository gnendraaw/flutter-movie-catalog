part of 'tv_recommendations_bloc.dart';

abstract class TvRecommendationsState extends Equatable {
  const TvRecommendationsState();

  @override
  List<Object?> get props => [];
}

class TvRecommendationsInitial extends TvRecommendationsState {}

class TvRecommendationsLoading extends TvRecommendationsState {}

class TvRecommendationsLoaded extends TvRecommendationsState {
  final List<Tv> result;

  TvRecommendationsLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class TvRecommendationsError extends TvRecommendationsState {
  final String message;

  TvRecommendationsError(this.message);

  @override
  List<Object?> get props => [message];
}
