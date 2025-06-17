import 'package:equatable/equatable.dart';

class InitPriceEvent extends PriceEvent {}

abstract class PriceEvent extends Equatable {
  const PriceEvent();

  @override
  List<Object> get props => [];
}

class FetchPriceEvent extends PriceEvent {
  final String symbol;

  const FetchPriceEvent(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class PriceUpdatedEvent extends PriceEvent {
  final double price;

  const PriceUpdatedEvent(this.price);

  @override
  List<Object> get props => [price];
}
