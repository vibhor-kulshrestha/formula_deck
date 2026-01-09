import 'package:flutter_test/flutter_test.dart';
import 'package:formula_deck/models/formula.dart';

void main() {
  group('Formula', () {
    test('creates formula from JSON correctly', () {
      final json = {
        'id': 'test_id',
        'title': 'Test Formula',
        'category': 'Algebra',
        'latex': 'x = a + b',
        'description': 'Test description',
        'variables': [
          {'name': 'a', 'type': 'double'},
          {'name': 'b', 'type': 'double'},
        ],
        'calculator': {
          'inputs': ['a', 'b'],
          'output': 'x',
        },
      };

      final formula = Formula.fromJson(json);

      expect(formula.id, 'test_id');
      expect(formula.title, 'Test Formula');
      expect(formula.category, 'Algebra');
      expect(formula.latex, 'x = a + b');
      expect(formula.description, 'Test description');
      expect(formula.variables.length, 2);
      expect(formula.calculator, isNotNull);
      expect(formula.calculator!.inputs, ['a', 'b']);
      expect(formula.calculator!.output, 'x');
    });

    test('converts formula to JSON correctly', () {
      final formula = Formula(
        id: 'test_id',
        title: 'Test Formula',
        category: 'Algebra',
        latex: 'x = a + b',
        description: 'Test description',
        variables: [
          Variable(name: 'a', type: 'double'),
          Variable(name: 'b', type: 'double'),
        ],
        calculator: CalculatorConfig(
          inputs: ['a', 'b'],
          output: 'x',
        ),
      );

      final json = formula.toJson();

      expect(json['id'], 'test_id');
      expect(json['title'], 'Test Formula');
      expect(json['category'], 'Algebra');
      expect(json['latex'], 'x = a + b');
      expect(json['description'], 'Test description');
      expect(json['variables'], isA<List>());
      expect(json['calculator'], isA<Map>());
    });

    test('creates copy with modified fields', () {
      final original = Formula(
        id: 'test_id',
        title: 'Original',
        category: 'Algebra',
        latex: 'x = a',
        description: 'Original description',
        variables: [],
      );

      final modified = original.copyWith(title: 'Modified');

      expect(modified.id, original.id);
      expect(modified.title, 'Modified');
      expect(modified.category, original.category);
    });
  });

  group('Variable', () {
    test('creates variable from JSON', () {
      final json = {
        'name': 'x',
        'type': 'double',
        'unit': 'm',
        'description': 'Distance',
      };

      final variable = Variable.fromJson(json);

      expect(variable.name, 'x');
      expect(variable.type, 'double');
      expect(variable.unit, 'm');
      expect(variable.description, 'Distance');
    });

    test('converts variable to JSON', () {
      final variable = Variable(
        name: 'x',
        type: 'double',
        unit: 'm',
        description: 'Distance',
      );

      final json = variable.toJson();

      expect(json['name'], 'x');
      expect(json['type'], 'double');
      expect(json['unit'], 'm');
      expect(json['description'], 'Distance');
    });
  });
}

