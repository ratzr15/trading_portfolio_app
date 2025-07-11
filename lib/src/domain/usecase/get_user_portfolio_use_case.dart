import 'package:trading_portfolio_app/src/domain/models/portfolio_model.dart';
import 'package:trading_portfolio_app/src/domain/repository/portfolio_instruments_repository.dart';

abstract class GetUserPortfolioUseCase {
  Future<PortfolioModel> call({required String userIdentifier});
}

class GetUserPortfolioUseCaseImpl implements GetUserPortfolioUseCase {
  final PortFolioInstrumentsRepository portFolioInstrumentsRepository;

  GetUserPortfolioUseCaseImpl({required this.portFolioInstrumentsRepository});

  @override
  Future<PortfolioModel> call({required String userIdentifier}) async {
    try {
      final result = await portFolioInstrumentsRepository(
        userIdentifier: userIdentifier,
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
