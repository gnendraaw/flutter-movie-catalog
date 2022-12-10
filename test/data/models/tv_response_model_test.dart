import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
      backdropPath: "/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg",
      firstAirDate: "2011-02-28",
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
      voteCount: 1471);

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return valid model from json', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_air.json'));

      // act
      final result = TvResponse.fromJson(jsonMap);

      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      //act
      final result = tTvResponseModel.toJson();

      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2022-10-12",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "name": "Name",
            "origin_country": ["JP"],
            "original_language": "Original Language",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
