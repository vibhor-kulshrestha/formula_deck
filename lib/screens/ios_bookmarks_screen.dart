import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/ios_formula_card.dart';
import '../providers/formula_provider.dart';

/// iOS-optimized bookmarks screen
class IOSBookmarksScreen extends ConsumerWidget {
  const IOSBookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedFormulasAsync = ref.watch(bookmarkedFormulasProvider);

    if (!Platform.isIOS) {
      return const SizedBox.shrink();
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Bookmarks',
          style: TextStyle(
            inherit: false,
            fontFamily: '.SF Pro Display',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.label,
          ),
        ),
        backgroundColor: const Color(0xFFF2F2F7).withValues(alpha: 0.8),
        border: null,
      ),
      child: SafeArea(
        child: bookmarkedFormulasAsync.when(
          data: (formulas) {
            if (formulas.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.bookmark,
                      size: 64,
                      color: CupertinoColors.secondaryLabel,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No bookmarks yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: '.SF Pro Display',
                        color: CupertinoColors.label,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the bookmark icon on any formula to save it',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: '.SF Pro Text',
                        color: CupertinoColors.secondaryLabel,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final formula = formulas[index];
                      return IOSFormulaCard(
                        formula: formula,
                        onTap: () {
                          context.push('/formula/${formula.id}');
                        },
                      );
                    },
                    childCount: formulas.length,
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(
            child: CupertinoActivityIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.exclamationmark_triangle,
                  size: 64,
                  color: CupertinoColors.systemRed,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading bookmarks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: '.SF Pro Display',
                    color: CupertinoColors.label,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

