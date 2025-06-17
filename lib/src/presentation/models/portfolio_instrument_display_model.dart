import 'package:equatable/equatable.dart';

class PortfolioInstrumentDisplayModel extends Equatable {
  final String description;
  final String symbol;

  const PortfolioInstrumentDisplayModel({
    required this.description,
    required this.symbol,
  });

  @override
  List<Object?> get props => [
        description,
        symbol,
      ];
}
