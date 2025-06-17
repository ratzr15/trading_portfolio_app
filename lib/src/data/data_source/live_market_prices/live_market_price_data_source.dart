import 'dart:async';
import 'dart:math';

class PriceDataSource {
  final Random _random = Random();
  final Map<String, double> _symbolCurrentPrices = {};
  final Map<String, StreamController<double>> _symbolPriceControllers = {};
  final Map<String, Timer> _symbolPriceTimers = {};

  PriceDataSource() {
    _symbolCurrentPrices['SXR8'] = 150.00;
    _symbolCurrentPrices['GOOG'] = 1200.00;
    _symbolCurrentPrices['TPR'] = 200.00;
    _symbolCurrentPrices['QCOM'] = 100.00;
    _symbolCurrentPrices['TSCO'] = 250.00;
  }

  /// Provides a stream for real-time price updates for a given [symbol].
  /// This stream will start updating when it has listeners and stop when none.
  Stream<double> streamPrice(String symbol) {
    if (!_symbolPriceControllers.containsKey(symbol)) {
      _symbolPriceControllers[symbol] = StreamController<double>.broadcast(
        onListen: () => _startPriceStreaming(symbol),
        onCancel: () => _stopPriceStreaming(symbol),
      );
      if (_symbolCurrentPrices.containsKey(symbol)) {
        _symbolPriceControllers[symbol]!.add(_symbolCurrentPrices[symbol]!);
      } else {
        //TODO: Log for observability
      }
    }
    return _symbolPriceControllers[symbol]!.stream;
  }

  void _startPriceStreaming(String symbol) {
    if (_symbolPriceTimers.containsKey(symbol)) {
      _symbolPriceTimers[symbol]?.cancel();
    }

    double currentPrice = _symbolCurrentPrices[symbol] ?? 100.0;
    _symbolPriceTimers[symbol] =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      final double changeFactor = 1 + (_random.nextDouble() * 0.2 - 0.1);
      final double newPrice =
          double.parse((currentPrice * changeFactor).toStringAsFixed(2));
      _symbolPriceControllers[symbol]?.add(newPrice);
      _symbolCurrentPrices[symbol] = newPrice;
      currentPrice = newPrice;
    });
  }

  void _stopPriceStreaming(String symbol) {
    _symbolPriceTimers[symbol]?.cancel();
    _symbolPriceControllers[symbol]?.close();
    _symbolPriceTimers.remove(symbol);
    _symbolPriceControllers.remove(symbol);
  }

  void dispose() {
    _symbolPriceTimers.forEach((_, timer) => timer.cancel());
    _symbolPriceControllers.forEach((_, controller) => controller.close());
    _symbolPriceTimers.clear();
    _symbolPriceControllers.clear();
  }
}
