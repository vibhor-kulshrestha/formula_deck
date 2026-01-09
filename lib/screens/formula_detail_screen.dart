import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/formula.dart';
import '../services/formula_service.dart';
import '../services/calculator_service.dart';
import '../services/hive_service.dart';
import '../providers/formula_provider.dart';
import '../widgets/latex_widget.dart';

/// Detail screen for a formula with calculator
class FormulaDetailScreen extends ConsumerStatefulWidget {
  final String formulaId;

  const FormulaDetailScreen({
    super.key,
    required this.formulaId,
  });

  @override
  ConsumerState<FormulaDetailScreen> createState() => _FormulaDetailScreenState();
}

class _FormulaDetailScreenState extends ConsumerState<FormulaDetailScreen> {
  Formula? _formula;
  final Map<String, TextEditingController> _controllers = {};
  double? _result;

  @override
  void initState() {
    super.initState();
    _loadFormula();
  }

  Future<void> _loadFormula() async {
    final formula = await FormulaService.getFormulaById(widget.formulaId);
    if (formula != null) {
      setState(() {
        _formula = formula;
        if (formula.calculator != null) {
          for (final input in formula.calculator!.inputs) {
            _controllers[input] = TextEditingController();
            _controllers[input]!.addListener(_calculate);
          }
        }
      });
    }
  }

  void _calculate() {
    if (_formula == null || _formula!.calculator == null) return;

    final inputs = <String, double>{};
    bool allValid = true;

    for (final input in _formula!.calculator!.inputs) {
      final controller = _controllers[input];
      if (controller == null || controller.text.isEmpty) {
        allValid = false;
        break;
      }
      final value = double.tryParse(controller.text);
      if (value == null) {
        allValid = false;
        break;
      }
      inputs[input] = value;
    }

    if (allValid && inputs.length == _formula!.calculator!.inputs.length) {
      setState(() {
        _result = CalculatorService.calculate(_formula!, inputs);
      });
    } else {
      setState(() {
        _result = null;
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_formula == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Formula Details')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final isBookmarked = ref.watch(isBookmarkedProvider(_formula!.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(_formula!.title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
          ),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.amber : null,
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              _toggleBookmark();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category chip
          Chip(
            label: Text(_formula!.category),
          ),
          const SizedBox(height: 16),
          // LaTeX formula
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            constraints: const BoxConstraints(
              minHeight: 80,
            ),
            child: Center(
              child: LaTeXWidget(
                latex: _formula!.latex,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Description
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            _formula!.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // Calculator section
          if (_formula!.calculator != null) ...[
            const SizedBox(height: 32),
            Text(
              'Calculator',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ..._formula!.calculator!.inputs.map((input) {
              final variable = _formula!.variables.firstWhere(
                (v) => v.name == input,
                orElse: () => Variable(name: input, type: 'double'),
              );
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  controller: _controllers[input],
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: variable.name + (variable.unit != null ? ' (${variable.unit})' : ''),
                    hintText: variable.description ?? 'Enter ${variable.name}',
                    border: const OutlineInputBorder(),
                  ),
                ),
              );
            }),
            if (_result != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      '${_formula!.calculator!.output} = ',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Expanded(
                      child: Text(
                        _result!.toStringAsFixed(4),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    ),
    );
  }

  void _toggleBookmark() {
    final bookmarkedIds = ref.read(bookmarkedIdsProvider);
    final newSet = Set<String>.from(bookmarkedIds);

    if (newSet.contains(_formula!.id)) {
      newSet.remove(_formula!.id);
      HiveService.removeBookmark(_formula!.id);
    } else {
      newSet.add(_formula!.id);
      HiveService.addBookmark(_formula!.id);
    }

    ref.read(bookmarkedIdsProvider.notifier).state = newSet;
  }
}

