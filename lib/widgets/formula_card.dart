import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/formula.dart';
import '../providers/formula_provider.dart';
import '../services/hive_service.dart';
import 'latex_widget.dart';

/// Card widget for displaying a formula
class FormulaCard extends ConsumerWidget {
  final Formula formula;
  final VoidCallback? onTap;

  const FormulaCard({
    super.key,
    required this.formula,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked = ref.watch(isBookmarkedProvider(formula.id));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap?.call();
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formula.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Chip(
                          label: Text(
                            formula.category,
                            style: const TextStyle(fontSize: 12),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? Colors.amber : null,
                    ),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      _toggleBookmark(ref, formula.id);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: const BoxConstraints(
                  minHeight: 50,
                ),
                child: LaTeXWidget(
                  latex: formula.latex,
                  fontSize: 18,
                ),
              ),
              if (formula.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  formula.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _toggleBookmark(WidgetRef ref, String formulaId) {
    final bookmarkedIds = ref.read(bookmarkedIdsProvider);
    final newSet = Set<String>.from(bookmarkedIds);

    if (newSet.contains(formulaId)) {
      newSet.remove(formulaId);
      HiveService.removeBookmark(formulaId);
    } else {
      newSet.add(formulaId);
      HiveService.addBookmark(formulaId);
    }

    ref.read(bookmarkedIdsProvider.notifier).state = newSet;
  }
}

