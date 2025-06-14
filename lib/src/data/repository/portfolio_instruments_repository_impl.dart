import 'package:trading_portfolio_app/src/data/data_source/portfolio_instruments/portfolio_instruments_data_source.dart';
import 'package:trading_portfolio_app/src/data/mappers/portfolio_instruments_remote_to_domain_mapper.dart';
import 'package:trading_portfolio_app/src/domain/models/portfolio_model.dart';
import 'package:trading_portfolio_app/src/domain/repository/portfolio_instruments_repository.dart';

class PortFolioInstrumentsRepositoryImpl
    implements PortFolioInstrumentsRepository {
  final PortfolioInstrumentsDataSource portfolioInstrumentsDataSource;
  final PortfolioInstrumentsRemoteToDomainMapper
      portfolioInstrumentsRemoteToDomainMapper;

  PortFolioInstrumentsRepositoryImpl({
    required this.portfolioInstrumentsDataSource,
    required this.portfolioInstrumentsRemoteToDomainMapper,
  });

  @override
  Future<PortfolioModel> call({required String userIdentifier}) async {
    final result =
        await portfolioInstrumentsDataSource(userIdentifier: userIdentifier);

    return portfolioInstrumentsRemoteToDomainMapper(result);
  }
}
