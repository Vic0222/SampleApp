import 'package:equatable/equatable.dart';

class CalculatorState extends Equatable {
  final String expression;
  final String errorMessage;

  const CalculatorState._(this.expression, {this.errorMessage = ""});

  const CalculatorState.inital() : this._("", errorMessage: "");

  const CalculatorState.success(String expression) : this._(expression);

  const CalculatorState.failed(String errorMessage)
      : this._("", errorMessage: errorMessage);

  @override
  List<Object?> get props => [expression, errorMessage];

  CalculatorState addSymbol(String symbol) {
    return CalculatorState._(
      expression + symbol,
    );
  }

  CalculatorState removeSymbol() {
    if (expression.isEmpty) {
      return this;
    }
    return CalculatorState._(
      expression.substring(0, expression.length - 1),
    );
  }

  CalculatorState copyWith({
    String? expression,
    String? errorMessage,
  }) {
    return CalculatorState._(
      expression ?? this.expression,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
