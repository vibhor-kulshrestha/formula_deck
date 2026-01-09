import 'package:flutter_test/flutter_test.dart';
import 'package:formula_deck/models/formula.dart';
import 'package:formula_deck/services/calculator_service.dart';

void main() {
  group('CalculatorService', () {
    test('calculates area of circle correctly', () {
      final formula = Formula(
        id: 'circle_area',
        title: 'Area of Circle',
        category: 'Geometry',
        latex: 'A=\\pi r^2',
        description: 'Area of a circle',
        variables: [
          Variable(name: 'r', type: 'double'),
        ],
        calculator: CalculatorConfig(
          inputs: ['r'],
          output: 'A',
        ),
      );

      final result = CalculatorService.calculate(formula, {'r': 5.0});
      expect(result, closeTo(78.54, 0.1));
    });

    test('calculates quadratic formula correctly', () {
      final formula = Formula(
        id: 'quadratic',
        title: 'Quadratic Formula',
        category: 'Algebra',
        latex: 'x=\\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}',
        description: 'Quadratic formula',
        variables: [
          Variable(name: 'a', type: 'double'),
          Variable(name: 'b', type: 'double'),
          Variable(name: 'c', type: 'double'),
        ],
        calculator: CalculatorConfig(
          inputs: ['a', 'b', 'c'],
          output: 'x',
        ),
      );

      final result = CalculatorService.calculate(formula, {
        'a': 1.0,
        'b': -5.0,
        'c': 6.0,
      });
      expect(result, closeTo(3.0, 0.1));
    });

    test('returns null for missing inputs', () {
      final formula = Formula(
        id: 'test',
        title: 'Test',
        category: 'Test',
        latex: 'x=a+b',
        description: 'Test',
        variables: [
          Variable(name: 'a', type: 'double'),
          Variable(name: 'b', type: 'double'),
        ],
        calculator: CalculatorConfig(
          inputs: ['a', 'b'],
          output: 'x',
        ),
      );

      final result = CalculatorService.calculate(formula, {'a': 1.0});
      expect(result, isNull);
    });

    test('returns null for formula without calculator', () {
      final formula = Formula(
        id: 'test',
        title: 'Test',
        category: 'Test',
        latex: 'x=a+b',
        description: 'Test',
        variables: [],
      );

      final result = CalculatorService.calculate(formula, {'a': 1.0});
      expect(result, isNull);
    });
  });
}

