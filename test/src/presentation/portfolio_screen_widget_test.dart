import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trading_portfolio_app/src/presentation/bloc/portfolio_screen_bloc.dart';
import 'package:trading_portfolio_app/src/presentation/bloc/portfolio_screen_event.dart';
import 'package:trading_portfolio_app/src/presentation/bloc/portfolio_screen_state.dart';
import 'package:trading_portfolio_app/src/presentation/models/portfolio_instrument_display_model.dart';
import 'package:trading_portfolio_app/src/presentation/portfolio_screen_widget.dart';

void main() {
  late MockPortfolioScreenBloc mockPortfolioScreenBloc;

  setUp(() {
    mockPortfolioScreenBloc = MockPortfolioScreenBloc();
    when(() => mockPortfolioScreenBloc.close()).thenAnswer((_) async {});
    registerFallbackValue(const PortfolioScreenInitialEvent());
    registerFallbackValue(MockPortfolioScreenState());
  });

  tearDown(() {
    mockPortfolioScreenBloc.close();
  });

  Widget createWidgetUnderTest({required PortfolioScreenState initialState}) {
    when(() => mockPortfolioScreenBloc.state).thenReturn(initialState);
    return MaterialApp(
      home: BlocProvider<PortfolioScreenBloc>(
        create: (context) => mockPortfolioScreenBloc,
        child:
            const PortfolioScreenWidget(userName: _DummyConstants.testUserName),
      ),
    );
  }

  testWidgets('renders loading state correctly', (WidgetTester tester) async {
    whenListen(
      mockPortfolioScreenBloc,
      Stream.fromIterable([PortfolioScreenLoadingState()]),
      initialState: PortfolioScreenLoadingState(),
    );

    await tester.pumpWidget(
        createWidgetUnderTest(initialState: PortfolioScreenLoadingState()));
    await tester.pumpAndSettle();

    expect(find.byKey(TradeListKeys.loading), findsOneWidget);
  });

  testWidgets('renders loaded state correctly with items',
      (WidgetTester tester) async {
    final List<PortfolioInstrumentDisplayModel> testItems = [
      const PortfolioInstrumentDisplayModel(
        symbol: _DummyConstants.testSymbol,
        description: _DummyConstants.testDescription,
      ),
    ];
    whenListen(
      mockPortfolioScreenBloc,
      Stream.fromIterable([PortfolioScreenLoadedState(testItems)]),
      initialState: PortfolioScreenLoadedState(testItems),
    );

    await tester.pumpWidget(createWidgetUnderTest(
        initialState: PortfolioScreenLoadedState(testItems)));
    await tester.pumpAndSettle();

    expect(find.byKey(TradeListKeys.loaded), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text(_DummyConstants.testSymbol), findsOneWidget);
    expect(find.text(_DummyConstants.testDescription), findsOneWidget);
  });

  testWidgets('renders error state correctly', (WidgetTester tester) async {
    whenListen(
      mockPortfolioScreenBloc,
      Stream.fromIterable([
        const PortfolioScreenErrorState(
          title: _DummyConstants.testErrorTitle,
        )
      ]),
      initialState: const PortfolioScreenErrorState(
        title: _DummyConstants.testErrorTitle,
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest(
        initialState: const PortfolioScreenErrorState(
      title: _DummyConstants.testErrorTitle,
    )));
    await tester.pumpAndSettle();

    expect(find.byKey(TradeListKeys.error), findsOneWidget);
    expect(find.text(_DummyConstants.testErrorTitle), findsOneWidget);
  });
}

class MockPortfolioScreenBloc extends Mock implements PortfolioScreenBloc {}

class MockPortfolioScreenState extends Mock implements PortfolioScreenState {}

class _DummyConstants {
  static const String testUserName = 'John Doe';
  static const String testErrorTitle = 'Test Error';
  static const String testSymbol = 'AAPL';
  static const String testDescription = 'Apple Inc.';
}
