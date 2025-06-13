import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trading_portfolio_app/src/data/data_source/portfolio_instruments/portfolio_instruments_data_source.dart';
import 'package:trading_portfolio_app/src/data/data_source/portfolio_instruments/portfolio_instruments_data_source_impl.dart';

//ignore_for_file: prefer_single_quotes
void main() {
  late PortfolioInstrumentsDataSource sut;
  late ApiClientMock apiClientMock;
  const String baseUrlDummy = 'https://example.org';

  setUp(() {
    registerFallbackValue(Options());

    // given
    apiClientMock = ApiClientMock();

    sut = PortfolioInstrumentsDataSourceImpl(
      apiClient: apiClientMock,
      baseUrl: baseUrlDummy,
    );
  });

  test(
      'Success: When datasource is called, should call apiClient with correct parameters and return positions list',
      () async {
    // Given
    final responseData = {
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
            "marketValue": 5134,
            "pnl": 1829.24,
            "pnlPercentage": 55.2
          },
        ]
      }
    };

    final expectedPositions = responseData as Map<String, dynamic>;

    when(
      () => apiClientMock.get(
        any(),
        options: any(named: 'options'),
        baseUrl: any(named: 'baseUrl'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: 'c/userIdentifier',
        ),
      ),
    );

    // When
    final actual = await sut(
      userIdentifier: 'userIdentifier',
    );

    // Then
    expect(actual, expectedPositions);

    verify(() => apiClientMock.get(
          'c/userIdentifier',
          options: any(named: 'options'),
          baseUrl: baseUrlDummy,
        )).called(1);
  });

  test('Failure: throws ArgumentError when userIdentifier is not passed',
      () async {
    // given
    final Response<dynamic> response = Response(
      statusCode: 400,
      requestOptions: RequestOptions(path: ''),
    );
    when(
      () => apiClientMock.get(
        any(),
        options: any(named: 'options'),
        baseUrl: any(named: 'baseUrl'),
      ),
    ).thenAnswer(
      (_) async => response,
    );

    // when & then
    await expectLater(
      () => sut(
        userIdentifier: '',
      ),
      throwsA(isA<ArgumentError>()),
    );
  });
}

class ApiClientMock extends Mock implements ApiClient {}
