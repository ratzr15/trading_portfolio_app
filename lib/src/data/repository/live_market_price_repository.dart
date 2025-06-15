import 'package:trading_portfolio_app/src/data/data_source/live_market_prices/live_market_price_data_source.dart';

class PriceRepositoryImpl {
  final PriceDataSource _priceDataSource;

  PriceRepositoryImpl(this._priceDataSource);

  Stream<double> getPriceStream(String symbol) {
    return _priceDataSource.streamPrice(symbol);
  }

  void dispose() {
    _priceDataSource.dispose();
  }
}
