import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_on_air.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvOnAir usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvOnAir(mockTvRepository);
  });

  final tTvs = <Tv>[];

  test('should get list of tvs from the repository', () async {
    // arrange
    when(mockTvRepository.getTvOnAir()).thenAnswer((_) async => Right(tTvs));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(tTvs));
  });
}
