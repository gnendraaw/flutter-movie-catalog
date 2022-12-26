import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/on_air_tv_bloc.dart';
import 'package:tv/presentation/pages/on_air_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockOnAirTvBloc extends Mock implements OnAirTvBloc {}

class FakeOnAirTvState extends Fake implements OnAirTvState {}

void main() {
  late MockOnAirTvBloc mockOnAirTvBloc;

  setUp(() {
    mockOnAirTvBloc = MockOnAirTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnAirTvBloc>.value(
      value: mockOnAirTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display center progress bar when bloc state is loading',
      (WidgetTester tester) async {
    when(() => mockOnAirTvBloc.stream)
        .thenAnswer((_) => Stream.value(OnAirTvLoading()));
    when(() => mockOnAirTvBloc.state).thenReturn(OnAirTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display listview when data is loaded',
      (WidgetTester tester) async {
    when(() => mockOnAirTvBloc.stream)
        .thenAnswer((_) => Stream.value(OnAirTvLoaded(testTvList)));
    when(() => mockOnAirTvBloc.state).thenReturn(OnAirTvLoaded(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display error message text when error',
      (WidgetTester tester) async {
    when(() => mockOnAirTvBloc.stream)
        .thenAnswer((_) => Stream.value(OnAirTvError('Error Message')));
    when(() => mockOnAirTvBloc.state).thenReturn(OnAirTvError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display blank container when bloc state is initial',
      (WidgetTester tester) async {
    when(() => mockOnAirTvBloc.stream)
        .thenAnswer((_) => Stream.value(OnAirTvInitial()));
    when(() => mockOnAirTvBloc.state).thenReturn(OnAirTvInitial());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(containerFinder, findsOneWidget);
  });
}
