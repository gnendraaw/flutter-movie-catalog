import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieTopRatedBloc extends Mock implements MovieTopRatedBloc {}

class FakeMovieTopRatedState extends Fake implements MovieTopRatedState {}

void main() {
  late MockMovieTopRatedBloc mockMovieTopRatedBloc;

  setUp(() {
    mockMovieTopRatedBloc = MockMovieTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>.value(
      value: mockMovieTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display center progress bar when bloc state is loading',
      (WidgetTester tester) async {
    when(() => mockMovieTopRatedBloc.stream)
        .thenAnswer((_) => Stream.value(MovieTopRatedLoading()));
    when(() => mockMovieTopRatedBloc.state).thenReturn(MovieTopRatedLoading());

    final centerFinder = find.byType(Center);
    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display listview when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMovieTopRatedBloc.stream)
        .thenAnswer((_) => Stream.value(MovieTopRatedLoaded(testMovieList)));
    when(() => mockMovieTopRatedBloc.state)
        .thenReturn(MovieTopRatedLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display error message text when error',
      (WidgetTester tester) async {
    when(() => mockMovieTopRatedBloc.stream)
        .thenAnswer((_) => Stream.value(MovieTopRatedError('Error Message')));
    when(() => mockMovieTopRatedBloc.state)
        .thenReturn(MovieTopRatedError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display blank container when bloc state is empty',
      (WidgetTester tester) async {
    when(() => mockMovieTopRatedBloc.stream)
        .thenAnswer((_) => Stream.value(MovieTopRatedEmpty()));
    when(() => mockMovieTopRatedBloc.state).thenReturn(MovieTopRatedEmpty());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(containerFinder, findsOneWidget);
  });
}
