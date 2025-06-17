import 'package:flutter_test/flutter_test.dart';
import 'package:trading_portfolio_app/src/data/mappers/portfolio_instruments_remote_to_domain_mapper.dart';
import 'package:trading_portfolio_app/src/domain/models/balance_model.dart';
import 'package:trading_portfolio_app/src/domain/models/portfolio_model.dart';
import 'package:trading_portfolio_app/src/domain/models/position_models.dart';

//ignore_for_file: prefer_single_quotes
void main() {
  late PortfolioInstrumentsRemoteToDomainMapper mapper;

  setUp(() {
    mapper = PortfolioInstrumentsRemoteToDomainMapper();
  });

  group('PortfolioInstrumentsRemoteToDomainMapper', () {
    test('correct mapping - full data', () {
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
            {
              "instrument": {
                "ticker": "GOOG",
                "name": "Alphabet Inc.",
                "exchange": "NASDAQ",
                "currency": "USD",
                "lastTradedPrice": 183.73
              },
              "quantity": 12.1,
              "averagePrice": 88.16,
              "cost": 1066.7,
              "marketValue": 2220.4,
              "pnl": 1155.8,
              "pnlPercentage": 108.1
            },
            {
              "instrument": {
                "ticker": "TPR",
                "name": "Tapestry Inc.",
                "exchange": "NYSE",
                "currency": "USD",
                "lastTradedPrice": 61.56
              },
              "quantity": 11.0,
              "averagePrice": 25.25,
              "cost": 277.7,
              "marketValue": 677.0,
              "pnl": 399.0,
              "pnlPercentage": 143.6
            },
            {
              "instrument": {
                "ticker": "QCOM",
                "name": "Qualcomm Inc.",
                "exchange": "NASDAQ",
                "currency": "USD",
                "lastTradedPrice": 157.2
              },
              "quantity": 5.0,
              "averagePrice": 147.76,
              "cost": 738.8,
              "marketValue": 785.6,
              "pnl": 46.9,
              "pnlPercentage": 6.34
            },
            {
              "instrument": {
                "ticker": "TSCO",
                "name": "Tesco Plc.",
                "exchange": "LSE",
                "currency": "GBP",
                "lastTradedPrice": 368.6
              },
              "quantity": 10.0,
              "averagePrice": 350.0,
              "cost": 3500.0,
              "marketValue": 3686.0,
              "pnl": 186.0,
              "pnlPercentage": 5.3
            }
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
          PositionModel(
            instrument: InstrumentModel(
              ticker: "GOOG",
              name: "Alphabet Inc.",
              exchange: "NASDAQ",
              currency: "USD",
              lastTradedPrice: 183.73,
            ),
            quantity: 12.1,
            averagePrice: 88.16,
            cost: 1066.7,
            marketValue: 2220.4,
            profitLossAmount: 1155.8,
            profitLossPercentage: 108.1,
          ),
          PositionModel(
            instrument: InstrumentModel(
              ticker: "TPR",
              name: "Tapestry Inc.",
              exchange: "NYSE",
              currency: "USD",
              lastTradedPrice: 61.56,
            ),
            quantity: 11.0,
            averagePrice: 25.25,
            cost: 277.7,
            marketValue: 677.0,
            profitLossAmount: 399.0,
            profitLossPercentage: 143.6,
          ),
          PositionModel(
            instrument: InstrumentModel(
              ticker: "QCOM",
              name: "Qualcomm Inc.",
              exchange: "NASDAQ",
              currency: "USD",
              lastTradedPrice: 157.2,
            ),
            quantity: 5.0,
            averagePrice: 147.76,
            cost: 738.8,
            marketValue: 785.6,
            profitLossAmount: 46.9,
            profitLossPercentage: 6.34,
          ),
          PositionModel(
            instrument: InstrumentModel(
              ticker: "TSCO",
              name: "Tesco Plc.",
              exchange: "LSE",
              currency: "GBP",
              lastTradedPrice: 368.6,
            ),
            quantity: 10.0,
            averagePrice: 350.0,
            cost: 3500.0,
            marketValue: 3686.0,
            profitLossAmount: 186.0,
            profitLossPercentage: 5.3,
          ),
        ],
      );

      final result = mapper(mockResponseData);

      expect(result.balance.netValue, expectedPortfolioModel.balance.netValue);
      expect(result.balance.profitLossAmount,
          expectedPortfolioModel.balance.profitLossAmount);
      expect(result.balance.profitLossPercentage,
          expectedPortfolioModel.balance.profitLossPercentage);

      expect(result.positions.length, expectedPortfolioModel.positions.length);

      for (int i = 0; i < result.positions.length; i++) {
        final actualPosition = result.positions[i];
        final expectedPosition = expectedPortfolioModel.positions[i];

        expect(actualPosition.instrument.ticker,
            expectedPosition.instrument.ticker);
        expect(
            actualPosition.instrument.name, expectedPosition.instrument.name);
        expect(actualPosition.instrument.exchange,
            expectedPosition.instrument.exchange);
        expect(actualPosition.instrument.currency,
            expectedPosition.instrument.currency);
        expect(actualPosition.instrument.lastTradedPrice,
            expectedPosition.instrument.lastTradedPrice);

        expect(actualPosition.quantity, expectedPosition.quantity);
        expect(actualPosition.averagePrice, expectedPosition.averagePrice);
        expect(actualPosition.cost, expectedPosition.cost);
        expect(actualPosition.marketValue, expectedPosition.marketValue);
        expect(
            actualPosition.profitLossAmount, expectedPosition.profitLossAmount);
        expect(actualPosition.profitLossPercentage,
            expectedPosition.profitLossPercentage);
      }
    });

    test('throws Exception when response is not a Map<String, dynamic>', () {
      final invalidResponse = [
        {'key': 'value'}
      ];

      expect(
        () => mapper(invalidResponse),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains(
              'Mapping exception: Response is not in the expected Map<String, dynamic> format.'),
        )),
      );
    });
  });
}
