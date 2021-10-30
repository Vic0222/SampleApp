import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/services/calculator_service.dart';

import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculatorService _calculatorService;

  CalculatorBloc(CalculatorService calculatorService)
      : _calculatorService = calculatorService,
        super(const CalculatorState.inital()) {
    on<CalculatorSymbolAdded>(_onCalculatorSymbolAdded);
    on<CalculatorSymbolRemoved>(_onCalculatorSymbolRemoved);
    on<CalculatorEvaluated>(_onCalculatorEvaluated);
  }

  FutureOr<void> _onCalculatorSymbolAdded(
      CalculatorSymbolAdded event, Emitter<CalculatorState> emit) {
    emit.call(state.copyWith(expression: state.expression + event.symbol));
  }

  FutureOr<void> _onCalculatorSymbolRemoved(
      CalculatorSymbolRemoved event, Emitter<CalculatorState> emit) {
    if (state.expression.isNotEmpty) {
      var newState = state.copyWith(
          expression:
              state.expression.substring(0, state.expression.length - 1));
      emit.call(newState);
    }
  }

  FutureOr<void> _onCalculatorEvaluated(
      CalculatorEvaluated event, Emitter<CalculatorState> emit) {
    try {
      var result = _calculatorService.evaluate(state.expression);
      emit.call(CalculatorState.success(result.toString()));
    } catch (e) {
      debugPrint(e.toString());
      emit.call(const CalculatorState.failed("Invalid Expression"));
    }
  }

  void addSymbol(String symbol) {
    add(CalculatorSymbolAdded(symbol));
  }

  void removeSymbol() {
    add(CalculatorSymbolRemoved());
  }

  void evaluate() {
    add(CalculatorEvaluated());
  }
}
