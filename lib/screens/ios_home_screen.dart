import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/ios_formula_card.dart';
import '../widgets/ipad_scaffold.dart';
import '../widgets/native_ad_widget.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/adaptive_search_field.dart';
import '../providers/formula_provider.dart';
import '../utils/platform_utils.dart';

/// iOS-optimized home screen with Cupertino design
class IOSHomeScreen extends ConsumerStatefulWidget {
  const IOSHomeScreen({super.key});

  @override
  ConsumerState<IOSHomeScreen> createState() => _IOSHomeScreenState();
}

class _IOSHomeScreenState extends ConsumerState<IOSHomeScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formulasAsync = ref.watch(filteredFormulasProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final isIPadAsync = ref.watch(isIPadProvider);

    if (!Platform.isIOS) {
      // Fallback - this shouldn't be called on non-iOS
      return const SizedBox.shrink();
    }

    return isIPadAsync.when(
      data: (isIPad) {
        // Use iPad scaffold if on iPad
        final content = CupertinoPageScaffold(
          navigationBar: isIPad
              ? null // No nav bar on iPad (sidebar handles navigation)
              : CupertinoNavigationBar(
              middle: Text(
                'FormulaDeck',
                style: TextStyle(
                  inherit: false,
                  fontFamily: '.SF Pro Display',
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.label,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    onPressed: () => context.push('/bookmarks'),
                    child: const Icon(CupertinoIcons.bookmark),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    onPressed: () => context.push('/settings'),
                    child: const Icon(CupertinoIcons.settings),
                  ),
                ],
              ),
              backgroundColor: CupertinoColors.systemGroupedBackground.withValues(alpha: 0.8),
              border: null,
            ),
      child: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AdaptiveSearchField(
                  controller: _searchController,
                  hintText: 'Search formulas...',
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                  },
                  onClear: () {
                    _searchController.clear();
                    ref.read(searchQueryProvider.notifier).state = '';
                  },
                ),
              ),
            ),
            // Category filter chips
            categoriesAsync.when(
              data: (categories) => SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: categories.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        final selectedCategory = ref.watch(selectedCategoryProvider);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            minimumSize: Size.zero,
                            color: selectedCategory == null
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.systemGrey5,
                            borderRadius: BorderRadius.circular(20),
                            onPressed: () {
                              ref.read(selectedCategoryProvider.notifier).state = null;
                            },
                            child: Text(
                              'All',
                              style: TextStyle(
                                color: selectedCategory == null
                                    ? CupertinoColors.white
                                    : CupertinoColors.label,
                                fontSize: 14,
                                fontFamily: '.SF Pro Text',
                              ),
                            ),
                          ),
                        );
                      }
                      final category = categories[index - 1];
                      final selectedCategory = ref.watch(selectedCategoryProvider);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          minimumSize: Size.zero,
                          color: selectedCategory == category
                              ? CupertinoColors.activeBlue
                              : CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.circular(20),
                          onPressed: () {
                            ref.read(selectedCategoryProvider.notifier).state =
                                selectedCategory == category ? null : category;
                          },
                          child: Text(
                            category,
                            style: TextStyle(
                              color: selectedCategory == category
                                  ? CupertinoColors.white
                                  : CupertinoColors.label,
                              fontSize: 14,
                              fontFamily: '.SF Pro Text',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              error: (error, stackTrace) => const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
            // Formula list
            formulasAsync.when(
              data: (formulas) {
                if (formulas.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.search,
                            size: 64,
                            color: CupertinoColors.secondaryLabel,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No formulas found',
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
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Show native ad every 10 formulas
                      if (index > 0 && index % 10 == 0) {
                        return const NativeAdWidget();
                      }

                      // Calculate formula index
                      final adCount = index ~/ 10;
                      final formulaIndex = index - adCount;
                      if (formulaIndex >= formulas.length) {
                        return const SizedBox.shrink();
                      }

                      final formula = formulas[formulaIndex];
                      return IOSFormulaCard(
                        formula: formula,
                        onTap: () {
                          context.push('/formula/${formula.id}');
                        },
                      );
                    },
                    childCount: formulas.length + (formulas.length ~/ 10),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
              error: (error, stackTrace) => SliverFillRemaining(
                child: Center(
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
                        'Error loading formulas',
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
            // Banner ad at bottom
            const SliverToBoxAdapter(
              child: BannerAdWidget(),
            ),
          ],
        ),
      ),
    );

        // Wrap with iPad scaffold if on iPad
        if (isIPad) {
          return IPadScaffold(body: content);
        }

        return content;
      },
      loading: () => const Center(child: CupertinoActivityIndicator()),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}

final isIPadProvider = FutureProvider<bool>((ref) async {
  return await PlatformUtils.isIPad;
});

