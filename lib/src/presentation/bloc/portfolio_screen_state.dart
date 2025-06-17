import 'package:equatable/equatable.dart';
import 'package:trading_portfolio_app/src/presentation/models/portfolio_instrument_display_model.dart';

abstract class PortfolioScreenState extends Equatable {
  const PortfolioScreenState();
}

class PortfolioScreenLoadingState extends PortfolioScreenState {
  @override
  List<Object?> get props => [];
}

class PortfolioScreenLoadedState extends PortfolioScreenState {
  final List<PortfolioInstrumentDisplayModel> displayModels;

  const PortfolioScreenLoadedState(this.displayModels);

  @override
  List<Object?> get props => [displayModels];
}

class PortfolioScreenErrorState extends PortfolioScreenState {
  final String title;

  const PortfolioScreenErrorState({required this.title});

  @override
  List<Object?> get props => [title];
}
