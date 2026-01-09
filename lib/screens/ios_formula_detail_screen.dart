import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/formula.dart';
import '../services/formula_service.dart';
import '../services/calculator_service.dart';
import '../services/hive_service.dart';
import '../providers/formula_provider.dart';
import '../widgets/latex_widget.dart';
import '../widgets/liquid_glass.dart';

/// iOS-optimized formula detail screen with Cupertino design
class IOSFormulaDetailScreen extends ConsumerStatefulWidget {
  final String formulaId;

  const IOSFormulaDetailScreen({
    super.key,
    required this.formulaId,
  });

  @override
  ConsumerState<IOSFormulaDetailScreen> createState() => _IOSFormulaDetailScreenState();
}

class _IOSFormulaDetailScreenState extends ConsumerState<IOSFormulaDetailScreen> {
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
      try {
        final result = CalculatorService.calculate(_formula!, inputs);
        setState(() {
          _result = result;
        });
      } catch (e) {
        setState(() {
          _result = null;
        });
      }
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
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Formula Details'),
        ),
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    final isBookmarked = ref.watch(isBookmarkedProvider(_formula!.id));

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          _formula!.title,
          style: TextStyle(
            inherit: false,
            fontFamily: '.SF Pro Display',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.label,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
          onPressed: () {
            HapticFeedback.mediumImpact();
            _toggleBookmark();
          },
          child: Icon(
            isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
            color: isBookmarked ? CupertinoColors.systemYellow : CupertinoColors.secondaryLabel,
          ),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground.withValues(alpha: 0.8),
        border: null,
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _formula!.category,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: '.SF Pro Text',
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // LaTeX formula with Liquid Glass
                    LiquidGlassContainer(
                      padding: const EdgeInsets.all(24),
                      borderRadius: BorderRadius.circular(20),
                      child: Center(
                        child: LaTeXWidget(
                          latex: _formula!.latex,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Description
                    Text(
                      'Description',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: '.SF Pro Display',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formula!.description,
                      style: const TextStyle(
                        fontSize: 17,
                        fontFamily: '.SF Pro Text',
                        color: CupertinoColors.label,
                      ),
                    ),
                    // Calculator section
                    if (_formula!.calculator != null) ...[
                      const SizedBox(height: 32),
                      Text(
                        'Calculator',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: '.SF Pro Display',
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
                          child: CupertinoTextField(
                            controller: _controllers[input],
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            placeholder: variable.description ?? 'Enter ${variable.name}',
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey6,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }),
                      if (_result != null) ...[
                        const SizedBox(height: 8),
                        LiquidGlassContainer(
                          padding: const EdgeInsets.all(20),
                          borderRadius: BorderRadius.circular(16),
                          child: Row(
                            children: [
                              Text(
                                '${_formula!.calculator!.output} = ',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: '.SF Pro Display',
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _result!.toStringAsFixed(4),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: '.SF Pro Display',
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
            ),
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

