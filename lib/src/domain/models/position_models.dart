class PositionModel {
  final InstrumentModel instrument;
  final double quantity;
  final double averagePrice;
  final double cost;
  final double marketValue;
  final double profitLossAmount;
  final double profitLossPercentage;

  PositionModel({
    required this.instrument,
    required this.quantity,
    required this.averagePrice,
    required this.cost,
    required this.marketValue,
    required this.profitLossAmount,
    required this.profitLossPercentage,
  });

  /// Factory constructor to create a [PositionModel] from a JSON map.
  factory PositionModel.fromJson(Map<String, dynamic> json) {
    final instrumentJson = json['instrument'] as Map<String, dynamic>;
    final instrument = InstrumentModel.fromJson(instrumentJson);

    return PositionModel(
      instrument: instrument,
      quantity: (json['quantity'] as num).toDouble(),
      averagePrice: (json['averagePrice'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      marketValue: (json['marketValue'] as num).toDouble(),
      profitLossAmount: (json['pnl'] as num).toDouble(),
      profitLossPercentage: (json['pnlPercentage'] as num).toDouble(),
    );
  }
}

class InstrumentModel {
  final String ticker;
  final String name;
  final String exchange;
  final String currency;
  final double lastTradedPrice;

  InstrumentModel(
      {required this.ticker,
      required this.name,
      required this.exchange,
      required this.currency,
      required this.lastTradedPrice});

  factory InstrumentModel.fromJson(dynamic json) {
    return InstrumentModel(
      ticker: json['ticker'] as String,
      name: json['name'] as String,
      exchange: json['exchange'] as String,
      currency: json['currency'] as String,
      lastTradedPrice: (json['lastTradedPrice'] as num).toDouble(),
    );
  }
}
