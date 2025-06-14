import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_portfolio_app/src/domain/usecase/get_user_portfolio_use_case.dart';
import 'package:trading_portfolio_app/src/presentation/bloc/portfolio_screen_event.dart';
import 'package:trading_portfolio_app/src/presentation/bloc/portfolio_screen_state.dart';
import 'package:trading_portfolio_app/src/presentation/mapper/portfolio_instruments_display_model_mapper.dart';

class PortfolioScreenBloc
    extends Bloc<PortfolioScreenInitialEvent, PortfolioScreenState> {
  final GetUserPortfolioUseCase getUserPortfolioUseCase;
  final PortfolioInstrumentsDisplayModelMapper portfolioScreenDisplayMapper;

  PortfolioScreenBloc({
    required this.getUserPortfolioUseCase,
    required this.portfolioScreenDisplayMapper,
  }) : super(PortfolioScreenLoadingState()) {
    on<PortfolioScreenInitialEvent>(_onListScreenInitialEvent);
  }

  Future<void> _onListScreenInitialEvent(
    PortfolioScreenInitialEvent event,
    Emitter<PortfolioScreenState> emit,
  ) async {
    try {
      emit(PortfolioScreenLoadingState());
      final response = await getUserPortfolioUseCase(
        userIdentifier: _Constants.userIdentifier,
      );

      if (response.positions.isEmpty) {
        emit(const PortfolioScreenErrorState(
            title: 'Sorry, user information not found'));
      } else {
        final displayItems =
            portfolioScreenDisplayMapper(domainModel: response);
        emit(PortfolioScreenLoadedState(displayItems));
      }
    } catch (e) {
      emit(const PortfolioScreenErrorState(
          title: 'Sorry, trade information could not be fetched'));
    }
  }
}

abstract class _Constants {
  static const userIdentifier = '60b7-70a6-4ee3-bae8';
}
