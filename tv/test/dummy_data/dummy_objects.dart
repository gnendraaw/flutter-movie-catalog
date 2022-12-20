import 'package:core/domain/entities/genre.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

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
