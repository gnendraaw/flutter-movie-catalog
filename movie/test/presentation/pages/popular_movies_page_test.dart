import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMoviePopularBloc extends Mock implements MoviePopularBloc {}

class FakeMoviePopularState extends Fake implements MoviePopularState {}

void main() {
  late MockMoviePopularBloc mockMoviePopularBloc;

  setUp(() {
    mockMoviePopularBloc = MockMoviePopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>.value(
      value: mockMoviePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display center progress bar when bloc state is loading',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.stream)
        .thenAnswer((_) => Stream.value(MoviePopularLoading()));
    when(() => mockMoviePopularBloc.state).thenReturn(MoviePopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display listview when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.stream)
        .thenAnswer((_) => Stream.value(MoviePopularLoaded(testMovieList)));
    when(() => mockMoviePopularBloc.state)
        .thenReturn(MoviePopularLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display error message text when error',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.stream)
        .thenAnswer((_) => Stream.value(MoviePopularError('Error Message')));
    when(() => mockMoviePopularBloc.state)
        .thenReturn(MoviePopularError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display blank container when bloc state is empty',
      (WidgetTester tester) async {
    when(() => mockMoviePopularBloc.stream)
        .thenAnswer((_) => Stream.value(MoviePopularEmpty()));
    when(() => mockMoviePopularBloc.state).thenReturn(MoviePopularEmpty());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(containerFinder, findsOneWidget);
  });
}
