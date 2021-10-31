// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:sample_app/services/calculator_service.dart';

void main() {
  test('Should add correctly', () {
    //arrange
    CalculatorService sut = CalculatorService();
    var expression = "1+1";

    //act
    var result = sut.evaluate(expression);

    //assert
    expect(result, equals("2.0"));
  });

  test('Should substract correctly', () {
    //arrange
    CalculatorService sut = CalculatorService();
    var expression = "10-1";

    //act
    var result = sut.evaluate(expression);

    //assert
    expect(result, equals("9.0"));
  });

  test('Should multiply correctly', () {
    //arrange
    CalculatorService sut = CalculatorService();
    var expression = "10*2";

    //act
    var result = sut.evaluate(expression);

    //assert
    expect(result, equals("20.0"));
  });

  test('Should multiply implicitly correctly', () {
    //arrange
    CalculatorService sut = CalculatorService();
    var expression = "2(2+5)";

    //act
    var result = sut.evaluate(expression);

    //assert
    expect(result, equals("14.0"));
  });

  test('Should divide correctly', () {
    //arrange
    CalculatorService sut = CalculatorService();
    var expression = "10/2";

    //act
    var result = sut.evaluate(expression);

    //assert
    expect(result, equals("5.0"));
  });
}
