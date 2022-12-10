import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getTvOnAir();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
}
