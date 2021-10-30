import 'package:math_expressions/math_expressions.dart';

class CalculatorService {
  final Parser parser = Parser();
  String evaluate(String expression) {
    Expression exp = parser.parse(preproccess(expression));
    return exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
  }

  //for some reason math expression can't proccess implicit multiplication (2(2+1) )
  String preproccess(String expression) {
    return expression.replaceAllMapped(RegExp(r"\d\("),
        (match) => "${match.group(0)?[0]}*${match.group(0)?[1]}");
  }
}
