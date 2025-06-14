import 'package:equatable/equatable.dart';
import 'package:trading_portfolio_app/src/presentation/models/portfolio_instrument_display_model.dart';

abstract class PortfolioScreenState extends Equatable {
  const PortfolioScreenState();
}

class TradeListScreenLoadingState extends PortfolioScreenState {
  @override
  List<Object?> get props => [];
}

class TradeListScreenLoadedState extends PortfolioScreenState {
  final List<PortfolioInstrumentDisplayModel> displayModels;

  const TradeListScreenLoadedState(this.displayModels);

  @override
  List<Object?> get props => [displayModels];
}

class TradeListScreenErrorState extends PortfolioScreenState {
  final String title;

  const TradeListScreenErrorState({required this.title});

  @override
  List<Object?> get props => [title];
}
