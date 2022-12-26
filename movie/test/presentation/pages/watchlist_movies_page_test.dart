import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieWatchlistBloc extends Mock implements MovieWatchlistBloc {}

class FakeMovieWatchlistState extends Fake implements MovieWatchlistState {}

void main() {
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(() {
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieWatchlistBloc>.value(
      value: mockMovieWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display center progress bar when bloc state is loading',
      (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(MovieWatchlistLoading()));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistLoading());

    final centerFinder = find.byType(Center);
    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display listview when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(MovieWatchlistLoaded(testMovieList)));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display error message text when error',
      (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(MovieWatchlistError('Error Message')));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display blank container when bloc state is initial',
      (WidgetTester tester) async {
    when(() => mockMovieWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(MovieWatchlistInitial()));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(MovieWatchlistInitial());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(containerFinder, findsOneWidget);
  });
}
