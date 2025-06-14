import 'package:trading_portfolio_app/src/domain/models/portfolio_model.dart';
import 'package:trading_portfolio_app/src/presentation/models/portfolio_instrument_display_model.dart';

class PortfolioInstrumentsDisplayModelMapper {
  List<PortfolioInstrumentDisplayModel> call({
    required PortfolioModel domainModel,
  }) {
    return domainModel.positions.map((position) {
      return PortfolioInstrumentDisplayModel(
        description: position.instrument.name,
        symbol: position.instrument.ticker,
      );
    }).toList();
  }
}
