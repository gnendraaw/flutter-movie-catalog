import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/failure.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getTvOnAir();
}
