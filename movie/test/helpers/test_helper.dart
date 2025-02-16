import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:http/io_client.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
  IOClient,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
