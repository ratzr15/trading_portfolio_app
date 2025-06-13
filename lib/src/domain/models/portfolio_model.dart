import 'package:trading_portfolio_app/src/domain/models/balance_model.dart';
import 'package:trading_portfolio_app/src/domain/models/position_models.dart';

class PortfolioModel {
  final BalanceModel balance;
  final List<PositionModel> positions;

  PortfolioModel({
    required this.balance,
    required this.positions,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    final portfolioJson = json['portfolio'] as Map<String, dynamic>;

    final balanceJson = portfolioJson['balance'] as Map<String, dynamic>;
    final balance = BalanceModel.fromJson(balanceJson);

    final positionsJson = portfolioJson['positions'] as List<dynamic>;
    final positions = positionsJson
        .map((e) => PositionModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return PortfolioModel(
      balance: balance,
      positions: positions,
    );
  }
}
