import 'package:core/data/models/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTv = Tv(
  backdropPath: "/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg",
  genreIds: [18, 80],
  id: 31586,
  name: "La Reina del Sur",
  originCountry: ["US"],
  originalLanguage: "es",
  originalName: "La Reina del Sur",
  overview:
      "After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...",
  popularity: 1476.202,
  posterPath: "/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg",
  voteAverage: 7.8,
  voteCount: 1471,
);

final testTvList = [testTv];

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvCache = TvTable(
  id: 31586,
  overview:
      "After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...",
  posterPath: "/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg",
  title: "La Reina del Sur",
);

final testTvFromCache = Tv.watchlist(
  id: 31586,
  overview:
      "After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...",
  posterPath: "/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg",
  name: "La Reina del Sur",
);

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: '/path.jpg',
  genres: [Genre(id: 1, name: 'Name')],
  id: 1,
  name: 'Name',
  overview: 'Overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvTable = TvTable(
  id: 1,
  title: 'Name',
  posterPath: '/path.jpg',
  overview: 'Overview',
);

final testTvMap = {
  "id": 1,
  "title": 'Name',
  "posterPath": '/path.jpg',
  "overview": 'Overview',
};

final testTvCacheMap = {
  "id": 31586,
  "title": 'La Reina del Sur',
  "posterPath": '/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg',
  "overview":
      'After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...',
};

final testWatchlistTvs = Tv.watchlist(
  id: 1,
  overview: 'Overview',
  posterPath: '/path.jpg',
  name: 'Name',
);
