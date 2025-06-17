import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_portfolio_app/src/domain/usecase/observe_real_time_price_use_case.dart';
import 'package:trading_portfolio_app/src/presentation/components/price/bloc/price_event.dart';
import 'package:trading_portfolio_app/src/presentation/components/price/bloc/price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  final ObserveRealTimePriceUseCase _observeRealTimePriceUseCase;
  StreamSubscription<double>? _priceSubscription;

  PriceBloc({
    required ObserveRealTimePriceUseCase observeRealTimePriceUseCase,
  })  : _observeRealTimePriceUseCase = observeRealTimePriceUseCase,
        super(PriceInitial()) {
    on<FetchPriceEvent>(_onFetchPrice);
    on<PriceUpdatedEvent>(_onPriceUpdated);
  }

  Future<void> _onFetchPrice(
    FetchPriceEvent event,
    Emitter<PriceState> emit,
  ) async {
    emit(PriceLoading());
    _priceSubscription?.cancel();
    try {
      _priceSubscription = _observeRealTimePriceUseCase(event.symbol).listen(
        (price) {
          add(PriceUpdatedEvent(price));
        },
        onError: (error) {
          emit(PriceError('Failed to get live price: $error'));
        },
      );
    } catch (e) {
      emit(PriceError('Failed to subscribe to price stream: ${e.toString()}'));
    }
  }

  void _onPriceUpdated(
    PriceUpdatedEvent event,
    Emitter<PriceState> emit,
  ) {
    emit(PriceLoaded(event.price));
  }

  @override
  Future<void> close() {
    _priceSubscription?.cancel();
    return super.close();
  }
}
