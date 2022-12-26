import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularTvBloc extends Mock implements PopularTvBloc {}

class FakePoularTvstate extends Fake implements PopularTvState {}

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display center progress bar when bloc state is loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoading()));
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display listview when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoaded(testTvList)));
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvLoaded(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display error message text when error',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvError('Error Message')));
    when(() => mockPopularTvBloc.state)
        .thenReturn(PopularTvError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display blank container when bloc state is initial',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvInitial()));
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvInitial());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(containerFinder, findsOneWidget);
  });
}
