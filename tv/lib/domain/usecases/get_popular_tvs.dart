import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetPopularTvs {
  final TvRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
