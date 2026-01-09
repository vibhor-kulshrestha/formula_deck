import 'formula.dart';

/// Category model for organizing formulas
class Category {
  final String name;
  final String icon;
  final int count;

  Category({
    required this.name,
    required this.icon,
    required this.count,
  });

  factory Category.fromFormulas(List<Formula> formulas, String categoryName) {
    final categoryFormulas = formulas.where((f) => f.category == categoryName).toList();
    return Category(
      name: categoryName,
      icon: _getCategoryIcon(categoryName),
      count: categoryFormulas.length,
    );
  }

  static String _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'algebra':
        return 'functions';
      case 'geometry':
        return 'square';
      case 'trigonometry':
        return 'waves';
      case 'calculus':
        return 'trending_up';
      case 'mechanics':
        return 'speed';
      case 'electricity':
        return 'bolt';
      case 'waves':
        return 'wifi';
      case 'thermodynamics':
        return 'whatshot';
      case 'optics':
        return 'light_mode';
      case 'chemistry':
        return 'science';
      default:
        return 'calculate';
    }
  }
}

