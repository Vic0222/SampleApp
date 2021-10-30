import 'package:equatable/equatable.dart';

class CalculatorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalculatorSymbolAdded extends CalculatorEvent {
  final String symbol;

  CalculatorSymbolAdded(this.symbol);

  @override
  List<Object?> get props => [symbol];
}

class CalculatorSymbolRemoved extends CalculatorEvent {}

class CalculatorEvaluated extends CalculatorEvent {}
