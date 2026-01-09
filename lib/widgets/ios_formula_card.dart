import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/formula.dart';
import '../providers/formula_provider.dart';
import '../services/hive_service.dart';
import 'latex_widget.dart';
import 'liquid_glass.dart';

/// iOS-optimized formula card with Liquid Glass effect
class IOSFormulaCard extends ConsumerWidget {
  final Formula formula;
  final VoidCallback? onTap;

  const IOSFormulaCard({
    super.key,
    required this.formula,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked = ref.watch(isBookmarkedProvider(formula.id));

    if (!Platform.isIOS) {
      // Fallback to regular card on Android
      return _buildMaterialCard(context, ref, isBookmarked);
    }

    return _buildIOSCard(context, ref, isBookmarked);
  }

  Widget _buildIOSCard(BuildContext context, WidgetRef ref, bool isBookmarked) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LiquidGlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(16),
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
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: '.SF Pro Display',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          formula.category,
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: '.SF Pro Text',
                            color: CupertinoColors.secondaryLabel,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    _toggleBookmark(ref, formula.id);
                  },
                  child: Icon(
                    isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                    color: isBookmarked ? CupertinoColors.systemYellow : CupertinoColors.secondaryLabel,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: LaTeXWidget(
                  latex: formula.latex,
                  fontSize: 18,
                ),
              ),
            ),
            if (formula.description.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                formula.description,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: '.SF Pro Text',
                  color: CupertinoColors.secondaryLabel,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialCard(BuildContext context, WidgetRef ref, bool isBookmarked) {
    // Import and use regular FormulaCard for Android
    // This is a fallback
    return Container(); // Will be handled by regular FormulaCard
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

