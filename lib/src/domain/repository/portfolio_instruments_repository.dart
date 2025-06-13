import 'package:trading_portfolio_app/src/domain/models/portfolio_model.dart';

abstract class PortFolioInstrumentsRepository {
  Future<PortfolioModel> call({
    required String userIdentifier,
  });
}
