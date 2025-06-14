import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trading_portfolio_app/src/data/data_source/portfolio_instruments/portfolio_instruments_data_source.dart';
import 'package:trading_portfolio_app/src/data/data_source/portfolio_instruments/portfolio_instruments_data_source_impl.dart';
import 'package:trading_portfolio_app/src/data/mappers/portfolio_instruments_remote_to_domain_mapper.dart';
import 'package:trading_portfolio_app/src/data/repository/portfolio_instruments_repository_impl.dart';
import 'package:trading_portfolio_app/src/domain/repository/portfolio_instruments_repository.dart';
import 'package:trading_portfolio_app/src/domain/usecase/get_user_portfolio_use_case.dart';
import 'package:trading_portfolio_app/src/presentation/bloc/portfolio_screen_bloc.dart';
import 'package:trading_portfolio_app/src/presentation/mapper/portfolio_instruments_display_model_mapper.dart';
import 'package:trading_portfolio_app/src/presentation/portfolio_screen_widget.dart';

class PortfolioScreenProvider extends StatelessWidget {
  const PortfolioScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return _registerRepositories(context);
  }
}

Widget _registerRepositories(BuildContext context) {
  return MultiProvider(
    providers: [
      Provider(create: (_) => _initTradeSymbolRepository(context)),
      Provider(create: (_) => _initGetTradeSymbolsUseCase(context)),
    ],
    builder: (context, __) => _registerUseCase(context),
  );
}

Widget _registerUseCase(BuildContext context) {
  return MultiProvider(
    providers: [
      Provider(create: (_) => context.read<GetUserPortfolioUseCase>()),
    ],
    child: _registerBloc(context),
  );
}

Widget _registerBloc(BuildContext context) {
  return MultiProvider(
    providers: [
      Provider(create: (_) => _initListBloc(context)),
    ],
    child: const PortfolioScreenWidget(
      userName: _Constants.userName,
    ),
  );
}

// Init methods
PortFolioInstrumentsRepository _initTradeSymbolRepository(
    BuildContext context) {
  return PortFolioInstrumentsRepositoryImpl(
    portfolioInstrumentsDataSource: _initTradeSymbolRemoteDataSource(),
    portfolioInstrumentsRemoteToDomainMapper: _initTradeRemoteToDomainMapper(),
  );
}

PortfolioInstrumentsDataSource _initTradeSymbolRemoteDataSource() {
  return PortfolioInstrumentsDataSourceImpl(
    apiClient: apiClient,
    baseUrl: _Constants.baseUrl,
  );
}

ApiClient get apiClient {
  var dio = Dio(BaseOptions(
    receiveTimeout: _Constants.fiveSeconds,
    connectTimeout: _Constants.fiveSeconds,
    sendTimeout: _Constants.fiveSeconds,
  ));
  return ApiClientImpl(dio);
}

PortfolioInstrumentsRemoteToDomainMapper _initTradeRemoteToDomainMapper() {
  return PortfolioInstrumentsRemoteToDomainMapper();
}

GetUserPortfolioUseCase _initGetTradeSymbolsUseCase(BuildContext context) {
  return GetUserPortfolioUseCaseImpl(
    portFolioInstrumentsRepository: _initTradeSymbolRepository(context),
  );
}

PortfolioScreenBloc _initListBloc(BuildContext context) {
  return PortfolioScreenBloc(
    getUserPortfolioUseCase: context.read(),
    portfolioScreenDisplayMapper: PortfolioInstrumentsDisplayModelMapper(),
  );
}

abstract class _Constants {
  static const fiveSeconds = Duration(seconds: 5);
  static const baseUrl = 'https://dummyjson.com';
  static const userName = 'John Doe';
}
