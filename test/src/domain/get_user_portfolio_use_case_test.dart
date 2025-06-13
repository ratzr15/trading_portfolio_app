import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trading_portfolio_app/src/domain/models/balance_model.dart';
import 'package:trading_portfolio_app/src/domain/models/portfolio_model.dart';
import 'package:trading_portfolio_app/src/domain/models/position_models.dart';
import 'package:trading_portfolio_app/src/domain/repository/portfolio_instruments_repository.dart';
import 'package:trading_portfolio_app/src/domain/usecase/get_user_portfolio_use_case.dart';

class MockPortFolioInstrumentsRepository extends Mock
    implements PortFolioInstrumentsRepository {}

void main() {
  late MockPortFolioInstrumentsRepository mockPortFolioInstrumentsRepository;
  late GetUserPortfolioUseCase sut;

  setUp(() {
    mockPortFolioInstrumentsRepository = MockPortFolioInstrumentsRepository();
    sut = GetUserPortfolioUseCaseImpl(
      portFolioInstrumentsRepository: mockPortFolioInstrumentsRepository,
    );
  });

  group('GetUserPortfolioUseCase', () {
    const tUserIdentifier = 'user123';

    // Define mock data for BalanceModel
    final tBalanceModel = BalanceModel(
      netValue: 1000.0,
      profitLossAmount: 50.0,
      profitLossPercentage: 5.0,
    );

    // Define mock data for InstrumentModel
    final tInstrumentModelAAPL = InstrumentModel(
      ticker: 'AAPL',
      name: 'Apple Inc.',
      exchange: 'NASDAQ',
      currency: 'USD',
      lastTradedPrice: 150.0,
    );

    final tInstrumentModelGOOGL = InstrumentModel(
      ticker: 'GOOGL',
      name: 'Alphabet Inc. (Class A)',
      exchange: 'NASDAQ',
      currency: 'USD',
      lastTradedPrice: 2000.0,
    );

    final tPositionModel1 = PositionModel(
      instrument: tInstrumentModelAAPL,
      quantity: 10.0,
      averagePrice: 145.0,
      cost: 1450.0,
      marketValue: 1500.0,
      profitLossAmount: 50.0,
      profitLossPercentage: 3.45,
    );

    final tPositionModel2 = PositionModel(
      instrument: tInstrumentModelGOOGL,
      quantity: 5.0,
      averagePrice: 1900.0,
      cost: 9500.0,
      marketValue: 10000.0,
      profitLossAmount: 500.0,
      profitLossPercentage: 5.26,
    );

    final tPortfolioModel = PortfolioModel(
      balance: tBalanceModel,
      positions: [tPositionModel1, tPositionModel2],
    );

    test('should return PortfolioModel when the repository call is successful',
        () async {
      // Arrange
      when(() => mockPortFolioInstrumentsRepository(
            userIdentifier: tUserIdentifier,
          )).thenAnswer((_) async => tPortfolioModel);

      // Act
      final result = await sut(userIdentifier: tUserIdentifier);

      // Assert
      expect(result, tPortfolioModel);
      verify(() => mockPortFolioInstrumentsRepository(
            userIdentifier: tUserIdentifier,
          )).called(1);
      verifyNoMoreInteractions(mockPortFolioInstrumentsRepository);
    });

    test('should rethrow the exception when the repository call fails',
        () async {
      // Arrange
      final tException = Exception('Something went wrong!');
      when(() => mockPortFolioInstrumentsRepository(
            userIdentifier: tUserIdentifier,
          )).thenThrow(tException);

      // Act & Assert
      expect(
        () async => await sut(userIdentifier: tUserIdentifier),
        throwsA(tException),
      );
      verify(() => mockPortFolioInstrumentsRepository(
            userIdentifier: tUserIdentifier,
          )).called(1);
      verifyNoMoreInteractions(mockPortFolioInstrumentsRepository);
    });
  });
}
