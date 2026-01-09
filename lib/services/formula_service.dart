import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/formula.dart';

/// Service for loading and managing formulas from JSON assets
class FormulaService {
  static List<Formula>? _formulas;
  static List<String>? _categories;

  /// Load formulas from JSON asset file
  static Future<List<Formula>> loadFormulas() async {
    if (_formulas != null) return _formulas!;

    try {
      final String jsonString = await rootBundle.loadString('assets/formulas.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> formulasJson = jsonData['formulas'] as List<dynamic>;

      _formulas = formulasJson
          .map((json) => Formula.fromJson(json as Map<String, dynamic>))
          .toList();

      return _formulas!;
    } catch (e) {
      throw Exception('Failed to load formulas: $e');
    }
  }

  /// Get all unique categories
  static Future<List<String>> getCategories() async {
    if (_categories != null) return _categories!;

    final formulas = await loadFormulas();
    _categories = formulas.map((f) => f.category).toSet().toList()..sort();
    return _categories!;
  }

  /// Search formulas by query
  static Future<List<Formula>> searchFormulas(String query) async {
    final formulas = await loadFormulas();
    if (query.isEmpty) return formulas;

    final lowerQuery = query.toLowerCase();
    return formulas.where((formula) {
      return formula.title.toLowerCase().contains(lowerQuery) ||
          formula.description.toLowerCase().contains(lowerQuery) ||
          formula.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Get formulas by category
  static Future<List<Formula>> getFormulasByCategory(String category) async {
    final formulas = await loadFormulas();
    return formulas.where((f) => f.category == category).toList();
  }

  /// Get formula by ID
  static Future<Formula?> getFormulaById(String id) async {
    final formulas = await loadFormulas();
    try {
      return formulas.firstWhere((f) => f.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Clear cache (useful for testing)
  static void clearCache() {
    _formulas = null;
    _categories = null;
  }
}

