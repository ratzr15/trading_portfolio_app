import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_portfolio_app/src/presentation/bloc/portfolio_screen_bloc.dart';
import 'package:trading_portfolio_app/src/presentation/bloc/portfolio_screen_event.dart';
import 'package:trading_portfolio_app/src/presentation/bloc/portfolio_screen_state.dart';
import 'package:trading_portfolio_app/src/presentation/models/portfolio_instrument_display_model.dart';
import 'package:utils/utils.dart';

class PortfolioScreenWidget extends StatefulWidget {
  final String userName;

  const PortfolioScreenWidget({
    super.key,
    required this.userName,
  });

  @override
  State<PortfolioScreenWidget> createState() => _TradeListScreenWidgetState();
}

class _TradeListScreenWidgetState extends State<PortfolioScreenWidget> {
  late PortfolioScreenBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = context.read<PortfolioScreenBloc>();
  }

  void _dispatch(PortfolioScreenInitialEvent event) => _bloc.add(event);

  @override
  Widget build(BuildContext context) {
    _dispatch(const PortfolioScreenInitialEvent());

    return Scaffold(
      appBar: CustomAppBar(
        userName: widget.userName,
      ),
      body: BlocConsumer<PortfolioScreenBloc, PortfolioScreenState>(
        bloc: _bloc,
        buildWhen: alwaysTrue,
        listenWhen: alwaysFalse,
        builder: _onStateChangeBuilder,
        listener: idleListener,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Widget _onStateChangeBuilder(
  BuildContext context,
  PortfolioScreenState state,
) {
  return _buildState(context, state);
}

Widget _buildState(BuildContext context, PortfolioScreenState state) {
  if (state is TradeListScreenLoadingState) {
    return const _TradeListLoadingWidget(
      key: TradeListKeys.loading,
    );
  } else if (state is TradeListScreenLoadedState) {
    return _TradeListLoadedWidget(
      key: TradeListKeys.loaded,
      portfolioDisplayItems: state.displayModels,
    );
  } else if (state is TradeListScreenErrorState) {
    return _TradeListErrorWidget(
      key: TradeListKeys.error,
      title: state.title,
    );
  } else {
    return const _TradeListErrorWidget(
      key: TradeListKeys.error,
      title: _Constants.errorTitle,
    );
  }
}

class _TradeListErrorWidget extends StatelessWidget {
  final String title;

  const _TradeListErrorWidget({
    required super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}

class _TradeListLoadingWidget extends StatelessWidget {
  const _TradeListLoadingWidget({
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        _Constants.loadingTitle,
      ),
    );
  }
}

class _TradeListLoadedWidget extends StatelessWidget {
  final List<PortfolioInstrumentDisplayModel> portfolioDisplayItems;

  const _TradeListLoadedWidget({
    required super.key,
    required this.portfolioDisplayItems,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: portfolioDisplayItems.length,
      itemBuilder: (context, index) {
        final item = portfolioDisplayItems[index];

        return Padding(
          padding: const EdgeInsets.all(Dimens.small),
          child: Row(
            children: [
              Container(
                width: Dimens.width,
                height: Dimens.height,
                color: DesignColor.background,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(
                  Dimens.small,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.symbol,
                        style: const TextStyle(
                          fontSize: Dimens.largeText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Dimens.small),
                      Text(
                        item.description,
                        style: const TextStyle(fontSize: Dimens.large),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

abstract class _Constants {
  static const errorTitle = 'Sorry, unexpected error';
  static const loadingTitle = 'Fetching your portfolio... 💲💲💲';
}

abstract class TradeListKeys {
  static const loading = Key('loading_key');
  static const loaded = Key('loaded_key');
  static const error = Key('error_key');
}
