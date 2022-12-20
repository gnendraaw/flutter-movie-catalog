import 'package:core/core.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvOnAir {
  final TvRepository repository;

  GetTvOnAir(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvOnAir();
  }
}
