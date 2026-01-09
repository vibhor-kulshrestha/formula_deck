import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/formula_card.dart';
import '../widgets/ios_formula_card.dart';
import '../widgets/native_ad_widget.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/adaptive_search_field.dart';
import '../providers/formula_provider.dart';
import 'ios_home_screen.dart';

/// Home screen with searchable formula list
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
    // Use iOS-optimized screen on iOS
    if (Platform.isIOS) {
      return const IOSHomeScreen();
    }

    final formulasAsync = ref.watch(filteredFormulasProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FormulaDeck'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => context.push('/bookmarks'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
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
          // Category filter chips
          categoriesAsync.when(
            data: (categories) => SizedBox(
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
                      child: FilterChip(
                        label: const Text('All'),
                        selected: selectedCategory == null,
                        onSelected: (selected) {
                          ref.read(selectedCategoryProvider.notifier).state = null;
                        },
                      ),
                    );
                  }
                  final category = categories[index - 1];
                  final selectedCategory = ref.watch(selectedCategoryProvider);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (selected) {
                        ref.read(selectedCategoryProvider.notifier).state =
                            selected ? category : null;
                      },
                    ),
                  );
                },
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => const SizedBox.shrink(),
          ),
          // Formula list
          Expanded(
            child: formulasAsync.when(
              data: (formulas) {
                if (formulas.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No formulas found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: formulas.length + (formulas.length ~/ 10) + 1,
                  itemBuilder: (context, index) {
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
                    // Use iOS card on iOS, Material card on Android
                    if (Platform.isIOS) {
                      return IOSFormulaCard(
                        formula: formula,
                        onTap: () {
                          context.push('/formula/${formula.id}');
                        },
                      );
                    }
                    return FormulaCard(
                      formula: formula,
                      onTap: () {
                        context.push('/formula/${formula.id}');
                      },
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading formulas',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(error.toString()),
                  ],
                ),
              ),
            ),
          ),
          // Banner ad at bottom
          const BannerAdWidget(),
        ],
      ),
    );
  }
}

