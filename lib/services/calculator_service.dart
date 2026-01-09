import 'dart:math' as math;
import '../models/formula.dart';

/// Service for calculating formula results
class CalculatorService {
  /// Calculate result based on formula and input values
  static double? calculate(
    Formula formula,
    Map<String, double> inputs,
  ) {
    if (formula.calculator == null) return null;

    try {
      final config = formula.calculator!;
      
      // Check if all required inputs are provided
      for (final input in config.inputs) {
        if (!inputs.containsKey(input) || inputs[input] == null) {
          return null;
        }
      }

      // Use custom formula if provided, otherwise use default calculation
      if (config.formula != null) {
        return _evaluateCustomFormula(config.formula!, inputs);
      }

      // Default calculation based on formula ID pattern
      return _calculateByFormulaId(formula.id, inputs);
    } catch (e) {
      return null;
    }
  }

  /// Evaluate custom formula string
  static double _evaluateCustomFormula(String formula, Map<String, double> inputs) {
    // Replace variable names with their values
    String expression = formula;
    inputs.forEach((key, value) {
      expression = expression.replaceAll(key, value.toString());
    });

    // Simple expression evaluator (for basic math operations)
    // In production, consider using a proper expression parser
    return _evaluateExpression(expression);
  }

  /// Evaluate mathematical expression
  static double _evaluateExpression(String expression) {
    // Remove whitespace
    expression = expression.replaceAll(' ', '');
    
    // Handle basic operations
    // This is a simplified evaluator - for production, use a proper parser
    try {
      // Handle parentheses
      while (expression.contains('(')) {
        final start = expression.lastIndexOf('(');
        final end = expression.indexOf(')', start);
        if (end == -1) break;
        
        final subExpr = expression.substring(start + 1, end);
        final result = _evaluateExpression(subExpr);
        expression = expression.replaceRange(start, end + 1, result.toString());
      }
      
      // Evaluate basic arithmetic
      return _evaluateBasic(expression);
    } catch (e) {
      return 0.0;
    }
  }

  static double _evaluateBasic(String expr) {
    // Handle addition/subtraction
    if (expr.contains('+')) {
      final parts = expr.split('+');
      return parts.map((p) => _evaluateBasic(p)).reduce((a, b) => a + b);
    }
    if (expr.contains('-') && expr.indexOf('-') > 0) {
      final parts = expr.split('-');
      double result = _evaluateBasic(parts[0]);
      for (int i = 1; i < parts.length; i++) {
        result -= _evaluateBasic(parts[i]);
      }
      return result;
    }
    
    // Handle multiplication/division
    if (expr.contains('*')) {
      final parts = expr.split('*');
      return parts.map((p) => _evaluateBasic(p)).reduce((a, b) => a * b);
    }
    if (expr.contains('/')) {
      final parts = expr.split('/');
      double result = _evaluateBasic(parts[0]);
      for (int i = 1; i < parts.length; i++) {
        result /= _evaluateBasic(parts[i]);
      }
      return result;
    }
    
    // Handle power
    if (expr.contains('^')) {
      final parts = expr.split('^');
      return math.pow(_evaluateBasic(parts[0]), _evaluateBasic(parts[1])).toDouble();
    }
    
    // Handle sqrt
    if (expr.startsWith('sqrt(') && expr.endsWith(')')) {
      final inner = expr.substring(5, expr.length - 1);
      return math.sqrt(_evaluateBasic(inner));
    }
    
    // Parse number
    return double.tryParse(expr) ?? 0.0;
  }

  /// Calculate by formula ID (common formulas)
  static double _calculateByFormulaId(String id, Map<String, double> inputs) {
    // Quadratic formula
    if (id.contains('quadratic')) {
      final a = inputs['a']!;
      final b = inputs['b']!;
      final c = inputs['c']!;
      final discriminant = b * b - 4 * a * c;
      if (discriminant < 0) return double.nan;
      return (-b + math.sqrt(discriminant)) / (2 * a);
    }

    // Area of circle
    if (id.contains('circle_area')) {
      final r = inputs['r'] ?? inputs['radius'] ?? 0.0;
      return math.pi * r * r;
    }

    // Area of rectangle
    if (id.contains('rectangle_area')) {
      final l = inputs['l'] ?? inputs['length'] ?? 0.0;
      final w = inputs['w'] ?? inputs['width'] ?? 0.0;
      return l * w;
    }

    // Area of triangle
    if (id.contains('triangle_area')) {
      final b = inputs['b'] ?? inputs['base'] ?? 0.0;
      final h = inputs['h'] ?? inputs['height'] ?? 0.0;
      return 0.5 * b * h;
    }

    // Distance formula
    if (id.contains('distance')) {
      final x1 = inputs['x1'] ?? 0.0;
      final y1 = inputs['y1'] ?? 0.0;
      final x2 = inputs['x2'] ?? 0.0;
      final y2 = inputs['y2'] ?? 0.0;
      return math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2));
    }

    // Pythagorean theorem
    if (id.contains('pythagorean')) {
      final a = inputs['a'] ?? 0.0;
      final b = inputs['b'] ?? 0.0;
      if (inputs.containsKey('c')) {
        final c = inputs['c']!;
        return math.sqrt(c * c - b * b);
      }
      return math.sqrt(a * a + b * b);
    }

    // Velocity
    if (id.contains('velocity')) {
      final d = inputs['d'] ?? inputs['distance'] ?? 0.0;
      final t = inputs['t'] ?? inputs['time'] ?? 0.0;
      if (t == 0) return double.infinity;
      return d / t;
    }

    // Acceleration
    if (id.contains('acceleration')) {
      final v = inputs['v'] ?? inputs['velocity'] ?? 0.0;
      final u = inputs['u'] ?? inputs['initial_velocity'] ?? 0.0;
      final t = inputs['t'] ?? inputs['time'] ?? 0.0;
      if (t == 0) return double.infinity;
      return (v - u) / t;
    }

    // Force (F = ma)
    if (id.contains('force') && !id.contains('electric')) {
      final m = inputs['m'] ?? inputs['mass'] ?? 0.0;
      final a = inputs['a'] ?? inputs['acceleration'] ?? 0.0;
      return m * a;
    }

    // Kinetic energy
    if (id.contains('kinetic_energy')) {
      final m = inputs['m'] ?? inputs['mass'] ?? 0.0;
      final v = inputs['v'] ?? inputs['velocity'] ?? 0.0;
      return 0.5 * m * v * v;
    }

    // Potential energy
    if (id.contains('potential_energy')) {
      final m = inputs['m'] ?? inputs['mass'] ?? 0.0;
      final g = inputs['g'] ?? 9.8;
      final h = inputs['h'] ?? inputs['height'] ?? 0.0;
      return m * g * h;
    }

    // Ohm's law
    if (id.contains('ohms_law')) {
      if (inputs.containsKey('V')) {
        final V = inputs['V']!;
        final I = inputs['I'] ?? inputs['current'] ?? 0.0;
        if (I == 0) return double.infinity;
        return V / I;
      }
      final V = inputs['V'] ?? inputs['voltage'] ?? 0.0;
      final R = inputs['R'] ?? inputs['resistance'] ?? 0.0;
      return V / R;
    }

    // Power (P = IV)
    if (id.contains('power') && id.contains('electric')) {
      final I = inputs['I'] ?? inputs['current'] ?? 0.0;
      final V = inputs['V'] ?? inputs['voltage'] ?? 0.0;
      return I * V;
    }

    // Simple interest
    if (id.contains('simple_interest')) {
      final P = inputs['P'] ?? inputs['principal'] ?? 0.0;
      final R = inputs['R'] ?? inputs['rate'] ?? 0.0;
      final T = inputs['T'] ?? inputs['time'] ?? 0.0;
      return (P * R * T) / 100;
    }

    // Compound interest
    if (id.contains('compound_interest')) {
      final P = inputs['P'] ?? inputs['principal'] ?? 0.0;
      final R = inputs['R'] ?? inputs['rate'] ?? 0.0;
      final n = inputs['n'] ?? inputs['compounds'] ?? 1.0;
      final t = inputs['t'] ?? inputs['time'] ?? 0.0;
      return P * math.pow(1 + (R / 100) / n, n * t) - P;
    }

    return 0.0;
  }
}

