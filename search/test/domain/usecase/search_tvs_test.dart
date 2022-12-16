import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_tvs.dart';

void main() {
  late SearchTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];
  final tQuery = 'halo';

  test('should get list of tvs from repository', () async {
    // arrange
    when(mockTvRepository.searchTvs(tQuery))
        .thenAnswer((_) async => Right(tTvs));

    // act
    final result = await usecase.execute(tQuery);

    // assert
    expect(result, Right(tTvs));
  });
}
