/// Formula model representing a mathematical or physics formula
class Formula {
  final String id;
  final String title;
  final String category;
  final String latex;
  final String description;
  final List<Variable> variables;
  final CalculatorConfig? calculator;

  Formula({
    required this.id,
    required this.title,
    required this.category,
    required this.latex,
    required this.description,
    required this.variables,
    this.calculator,
  });

  factory Formula.fromJson(Map<String, dynamic> json) {
    return Formula(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      latex: json['latex'] as String,
      description: json['description'] as String,
      variables: (json['variables'] as List<dynamic>?)
              ?.map((v) => Variable.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
      calculator: json['calculator'] != null
          ? CalculatorConfig.fromJson(json['calculator'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'latex': latex,
      'description': description,
      'variables': variables.map((v) => v.toJson()).toList(),
      'calculator': calculator?.toJson(),
    };
  }

  Formula copyWith({
    String? id,
    String? title,
    String? category,
    String? latex,
    String? description,
    List<Variable>? variables,
    CalculatorConfig? calculator,
  }) {
    return Formula(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      latex: latex ?? this.latex,
      description: description ?? this.description,
      variables: variables ?? this.variables,
      calculator: calculator ?? this.calculator,
    );
  }
}

/// Variable model for formula inputs/outputs
class Variable {
  final String name;
  final String type;
  final String? unit;
  final String? description;

  Variable({
    required this.name,
    required this.type,
    this.unit,
    this.description,
  });

  factory Variable.fromJson(Map<String, dynamic> json) {
    return Variable(
      name: json['name'] as String,
      type: json['type'] as String,
      unit: json['unit'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      if (unit != null) 'unit': unit,
      if (description != null) 'description': description,
    };
  }
}

/// Calculator configuration for formula calculations
class CalculatorConfig {
  final List<String> inputs;
  final String output;
  final String? formula;

  CalculatorConfig({
    required this.inputs,
    required this.output,
    this.formula,
  });

  factory CalculatorConfig.fromJson(Map<String, dynamic> json) {
    return CalculatorConfig(
      inputs: (json['inputs'] as List<dynamic>).map((e) => e as String).toList(),
      output: json['output'] as String,
      formula: json['formula'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inputs': inputs,
      'output': output,
      if (formula != null) 'formula': formula,
    };
  }
}
