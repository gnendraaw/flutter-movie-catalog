import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTvBloc extends Mock implements TopRatedTvBloc {}

class FakeTopRatedTvState extends Fake implements TopRatedTvState {}

void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUp(() {
    mockTopRatedTvBloc = MockTopRatedTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display center progress bar when bloc state is loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvLoading()));
    when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display listview when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvLoaded(testTvList)));
    when(() => mockTopRatedTvBloc.state)
        .thenReturn(TopRatedTvLoaded(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display error message text when error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvError('Error Message')));
    when(() => mockTopRatedTvBloc.state)
        .thenReturn(TopRatedTvError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display blank container when bloc state is initial',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvInitial()));
    when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvInitial());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(containerFinder, findsOneWidget);
  });
}
