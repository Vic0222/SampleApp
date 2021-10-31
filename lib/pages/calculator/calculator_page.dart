import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/blocs/calculator/calculator_bloc.dart';
import 'package:sample_app/blocs/calculator/calculator_state.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
              return Text(
                state.expression.isEmpty ? "0" : state.expression,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.headline4,
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CalculatorButton("("),
              const CalculatorButton(")"),
              ElevatedButton(
                child: const Icon(Icons.backspace),
                onPressed: () {
                  context.read<CalculatorBloc>().removeSymbol();
                },
              ),
              ElevatedButton(
                child: const Text("="),
                onPressed: () {
                  context.read<CalculatorBloc>().evaluate();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CalculatorButton("7"),
              CalculatorButton("8"),
              CalculatorButton("9"),
              CalculatorButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CalculatorButton("4"),
              CalculatorButton("5"),
              CalculatorButton("6"),
              CalculatorButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CalculatorButton("1"),
              CalculatorButton("2"),
              CalculatorButton("3"),
              CalculatorButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ElevatedButton(
                child: null,
                onPressed: null,
              ),
              CalculatorButton("0"),
              CalculatorButton("."),
              CalculatorButton("+"),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String _symbol;

  const CalculatorButton(String symbol, {Key? key})
      : _symbol = symbol,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(_symbol),
      onPressed: () => {context.read<CalculatorBloc>().addSymbol(_symbol)},
    );
  }
}
