import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:trading_portfolio_app/src/data/data_source/portfolio_instruments/portfolio_instruments_data_source.dart';

class PortfolioInstrumentsDataSourceImpl
    implements PortfolioInstrumentsDataSource {
  final ApiClient _apiClient;
  final String _baseUrl;

  const PortfolioInstrumentsDataSourceImpl({
    required ApiClient apiClient,
    required String baseUrl,
  })  : _apiClient = apiClient,
        _baseUrl = baseUrl;

  @override
  Future<Map<String, dynamic>> call({
    required String userIdentifier,
  }) async {
    if (userIdentifier.isEmpty) {
      throw ArgumentError('Identifier is required');
    }

    final path = 'c/$userIdentifier';

    final dynamic response = await _apiClient.get(
      path,
      options: Options(headers: const {}),
      baseUrl: _baseUrl,
    );

    if (response.statusCode == 200) {
      final responseData = response.data;
      if (responseData != null) {
        if (responseData is Map<String, dynamic>) {
          return responseData;
        } else {
          throw Exception(
            'Response is not in proper format, Expected in Map<String, dynamic>',
          );
        }
      } else {
        throw Exception('No response from $path');
      }
    } else {
      throw Exception(
        'Error while fetching data from $path, status code: ${response.statusCode}',
      );
    }
  }
}
