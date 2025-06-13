import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trading_portfolio_app/src/data/data_source/portfolio_instruments/portfolio_instruments_data_source.dart';
import 'package:trading_portfolio_app/src/data/mappers/portfolio_instruments_remote_to_domain_mapper.dart';
import 'package:trading_portfolio_app/src/data/repository/portfolio_instruments_repository_impl.dart';
import 'package:trading_portfolio_app/src/domain/models/balance_model.dart';
import 'package:trading_portfolio_app/src/domain/models/portfolio_model.dart';
import 'package:trading_portfolio_app/src/domain/models/position_models.dart';
import 'package:trading_portfolio_app/src/domain/repository/portfolio_instruments_repository.dart';

//ignore_for_file: prefer_single_quotes
class MockPortfolioInstrumentsDataSource extends Mock
    implements PortfolioInstrumentsDataSource {}

class MockPortfolioInstrumentsRemoteToDomainMapper extends Mock
    implements PortfolioInstrumentsRemoteToDomainMapper {}

void main() {
  late PortFolioInstrumentsRepository sut;
  late MockPortfolioInstrumentsDataSource mockDataSource;
  late MockPortfolioInstrumentsRemoteToDomainMapper mockMapper;

  setUp(() {
    mockDataSource = MockPortfolioInstrumentsDataSource();
    mockMapper = MockPortfolioInstrumentsRemoteToDomainMapper();

    sut = PortFolioInstrumentsRepositoryImpl(
      portfolioInstrumentsDataSource: mockDataSource,
      portfolioInstrumentsRemoteToDomainMapper: mockMapper,
    );
  });

  group('PortfolioRepositoryImpl', () {
    final Map<String, dynamic> mockResponseData = {
      "portfolio": {
        "balance": {
          "netValue": 32432.54,
          "pnl": 10332.55,
          "pnlPercentage": 31.52
        },
        "positions": [
          {
            "instrument": {
              "ticker": "SXR8",
              "name": "iShares Core S&P 500",
              "exchange": "IBIS",
              "currency": "EUR",
              "lastTradedPrice": 611.64
            },
            "quantity": 8.4,
            "averagePrice": 393.77,
            "cost": 3307.7,
            "marketValue": 5134.0,
            "pnl": 1829.24,
            "pnlPercentage": 55.2
          },
        ]
      }
    };

    final expectedPortfolioModel = PortfolioModel(
      balance: BalanceModel(
        netValue: 32432.54,
        profitLossAmount: 10332.55,
        profitLossPercentage: 31.52,
      ),
      positions: [
        PositionModel(
          instrument: InstrumentModel(
            ticker: "SXR8",
            name: "iShares Core S&P 500",
            exchange: "IBIS",
            currency: "EUR",
            lastTradedPrice: 611.64,
          ),
          quantity: 8.4,
          averagePrice: 393.77,
          cost: 3307.7,
          marketValue: 5134.0,
          profitLossAmount: 1829.24,
          profitLossPercentage: 55.2,
        ),
      ],
    );

    test(
        'Success: should return PortfolioModel if data source and mapper succeed',
        () async {
      // Arrange
      const userIdentifier = 'testUser123';

      when(() => mockDataSource(userIdentifier: userIdentifier))
          .thenAnswer((_) async => mockResponseData);

      when(() => mockMapper(mockResponseData))
          .thenReturn(expectedPortfolioModel);

      // Act
      final result = await sut(userIdentifier: userIdentifier);

      // Assert
      expect(result, expectedPortfolioModel);

      verify(() => mockDataSource(userIdentifier: userIdentifier)).called(1);
      verify(() => mockMapper(mockResponseData)).called(1);
      verifyNoMoreInteractions(mockDataSource);
      verifyNoMoreInteractions(mockMapper);
    });

    test('Failure: should rethrow exception if data source throws an exception',
        () async {
      // Arrange
      const userIdentifier = 'testUser123';
      final exception =
          Exception('Failed to fetch portfolio data from data source');

      when(() => mockDataSource(userIdentifier: userIdentifier))
          .thenThrow(exception);

      // Act & Assert
      await expectLater(
        () => sut(userIdentifier: userIdentifier),
        throwsA(equals(exception)),
      );

      verify(() => mockDataSource(userIdentifier: userIdentifier)).called(1);
      verifyZeroInteractions(mockMapper);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('Failure: should rethrow exception if mapper throws an exception',
        () async {
      // Arrange
      const userIdentifier = 'testUser123';
      final mappingException =
          Exception('Failed to map portfolio data in mapper');

      when(() => mockDataSource(userIdentifier: userIdentifier))
          .thenAnswer((_) async => mockResponseData);

      when(() => mockMapper(mockResponseData)).thenThrow(mappingException);

      // Act & Assert
      await expectLater(
        () => sut(userIdentifier: userIdentifier),
        throwsA(equals(mappingException)),
      );

      verify(() => mockDataSource(userIdentifier: userIdentifier)).called(1);
      verify(() => mockMapper(mockResponseData)).called(1);
      verifyNoMoreInteractions(mockDataSource);
      verifyNoMoreInteractions(mockMapper);
    });
  });
}
