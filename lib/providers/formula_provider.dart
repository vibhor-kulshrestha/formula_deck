import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/formula.dart';
import '../services/formula_service.dart';
import '../services/hive_service.dart';

/// Provider for all formulas
final formulasProvider = FutureProvider<List<Formula>>((ref) async {
  return await FormulaService.loadFormulas();
});

/// Provider for categories
final categoriesProvider = FutureProvider<List<String>>((ref) async {
  return await FormulaService.getCategories();
});

/// Provider for search query
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Provider for selected category filter
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Provider for filtered formulas based on search and category
final filteredFormulasProvider = FutureProvider<List<Formula>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final category = ref.watch(selectedCategoryProvider);
  final allFormulas = await ref.watch(formulasProvider.future);

  var filtered = allFormulas;

  // Apply category filter
  if (category != null && category.isNotEmpty) {
    filtered = filtered.where((f) => f.category == category).toList();
  }

  // Apply search filter
  if (query.isNotEmpty) {
    final lowerQuery = query.toLowerCase();
    filtered = filtered.where((formula) {
      return formula.title.toLowerCase().contains(lowerQuery) ||
          formula.description.toLowerCase().contains(lowerQuery) ||
          formula.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  return filtered;
});

/// Provider for bookmarked formula IDs
final bookmarkedIdsProvider = StateProvider<Set<String>>((ref) {
  return HiveService.getBookmarkedIds().toSet();
});

/// Provider for bookmarked formulas
final bookmarkedFormulasProvider = FutureProvider<List<Formula>>((ref) async {
  final bookmarkedIds = ref.watch(bookmarkedIdsProvider);
  final allFormulas = await ref.watch(formulasProvider.future);
  
  return allFormulas.where((f) => bookmarkedIds.contains(f.id)).toList();
});

/// Provider for checking if formula is bookmarked
final isBookmarkedProvider = Provider.family<bool, String>((ref, formulaId) {
  final bookmarkedIds = ref.watch(bookmarkedIdsProvider);
  return bookmarkedIds.contains(formulaId);
});

/// Provider for dark mode
final darkModeProvider = StateProvider<bool>((ref) {
  return HiveService.isDarkModeEnabled();
});

/// Provider for ads removed status
final adsRemovedProvider = StateProvider<bool>((ref) {
  return HiveService.areAdsRemoved();
});

