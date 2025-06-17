import 'package:trading_portfolio_app/src/data/repository/live_market_price_repository.dart';

class ObserveRealTimePriceUseCase {
  final PriceRepositoryImpl _priceRepository;

  ObserveRealTimePriceUseCase(this._priceRepository);

  Stream<double> call(String symbol) {
    return _priceRepository.getPriceStream(symbol);
  }
}
