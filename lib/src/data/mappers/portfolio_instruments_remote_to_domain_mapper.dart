import 'package:trading_portfolio_app/src/domain/models/portfolio_model.dart';

class PortfolioInstrumentsRemoteToDomainMapper {
  PortfolioModel call(dynamic response) {
    if (response is Map<String, dynamic>) {
      return PortfolioModel.fromJson(response);
    } else {
      throw Exception(
          'Mapping exception: Response is not in the expected Map<String, dynamic> format.');
    }
  }
}
