class BalanceModel {
  final double netValue;
  final double profitLossAmount;
  final double profitLossPercentage;

  BalanceModel({
    required this.netValue,
    required this.profitLossAmount,
    required this.profitLossPercentage,
  });

  factory BalanceModel.fromJson(dynamic json) {
    return BalanceModel(
      netValue: (json['netValue'] as num).toDouble(),
      profitLossAmount: (json['pnl'] as num).toDouble(),
      profitLossPercentage: (json['pnlPercentage'] as num).toDouble(),
    );
  }
}
