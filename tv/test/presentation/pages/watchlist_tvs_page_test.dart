import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/pages/watchlist_tvs_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvWatchlistBloc extends Mock implements TvWatchlistBloc {}

class FakeTvWatchlistState extends Fake implements TvWatchlistState {}

void main() {
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(() {
    mockTvWatchlistBloc = MockTvWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvWatchlistBloc>.value(
      value: mockTvWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display center progress bar when bloc state is loading',
      (WidgetTester tester) async {
    when(() => mockTvWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(TvWatchlistLoading()));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistLoading());

    final centerFinder = find.byType(Center);
    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display listview when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(TvWatchlistLoaded(testTvList)));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(TvWatchlistLoaded(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display error message text when error',
      (WidgetTester tester) async {
    when(() => mockTvWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(TvWatchlistError('Error Message')));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(TvWatchlistError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display blank container when bloc state is initial',
      (WidgetTester tester) async {
    when(() => mockTvWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(TvWatchlistInitial()));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistInitial());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(containerFinder, findsOneWidget);
  });
}
