import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trading_portfolio_app/src/domain/usecase/observe_real_time_price_use_case.dart';
import 'package:trading_portfolio_app/src/presentation/components/price/bloc/price_bloc.dart';
import 'package:trading_portfolio_app/src/presentation/components/price/bloc/price_event.dart';
import 'package:trading_portfolio_app/src/presentation/components/price/bloc/price_state.dart';

class PriceWidget extends StatefulWidget {
  final String symbol;

  const PriceWidget({
    super.key,
    required this.symbol,
  });

  @override
  State<PriceWidget> createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
  late PriceBloc _priceBloc;
  final NumberFormat currencyFormatter = NumberFormat.currency(symbol: '\$');

  @override
  void initState() {
    super.initState();
    _priceBloc = PriceBloc(
      observeRealTimePriceUseCase: context.read<ObserveRealTimePriceUseCase>(),
    );
    _priceBloc.add(FetchPriceEvent(widget.symbol));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PriceBloc>.value(
      value: _priceBloc,
      child: BlocBuilder<PriceBloc, PriceState>(
        builder: (context, state) {
          if (state is PriceLoaded) {
            return Text(
              currencyFormatter.format(state.price),
              style: const TextStyle(
                fontSize: FontSize.content,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            );
          } else if (state is PriceLoading) {
            return const SizedBox(
              width: _Constants.widgetHeightAndWidth,
              height: _Constants.widgetHeightAndWidth,
              child: CircularProgressIndicator(
                strokeWidth: _Constants.indicatorWidth,
              ),
            );
          } else if (state is PriceError) {
            return const Icon(
              Icons.error,
              color: Colors.red,
              size: _Constants.widgetHeightAndWidth,
            );
          }
          return const Text('N/A');
        },
      ),
    );
  }

  @override
  void dispose() {
    _priceBloc.close();
    super.dispose();
  }
}

abstract class _Constants {
  static const double widgetHeightAndWidth = 18;
  static const double indicatorWidth = 2.0;
}
