import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/quote_model.dart';
import '../../settings/bindings/settings_binding.dart';
import '../../settings/views/settings_view.dart';
import '../controllers/quote_detail_controller.dart';

class QuoteDetailView extends GetView<QuoteDetailController> {
  const QuoteDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colorScheme.surface, colorScheme.surfaceVariant],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quote of the Day',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings, color: colorScheme.onSurface),
                      onPressed: () {
                        Get.to(
                          () => const SettingsView(),
                          binding: SettingsBinding(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Quote Card
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            controller.errorMessage.value,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          FilledButton(
                            onPressed: controller.fetchRandomQuote,
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }

                  final quote = controller.quote.value;
                  if (quote == null) {
                    return Center(
                      child: Text(
                        'No quote available',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: _QuoteCard(quote: quote),
                  );
                }),
              ),
              // Bottom Action Bar
              Obx(
                () => _BottomActionBar(
                  isBookmarked: controller.isBookmarked.value,
                  onBookmark: controller.toggleBookmark,
                  onShare: controller.shareQuote,
                  onNewQuote: controller.fetchRandomQuote,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"',
            style: textTheme.displaySmall?.copyWith(
              color: colorScheme.primary,
              height: 0.8,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            quote.content,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '— ${quote.author}',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.isBookmarked,
    required this.onBookmark,
    required this.onShare,
    required this.onNewQuote,
  });

  final bool isBookmarked;
  final VoidCallback onBookmark;
  final VoidCallback onShare;
  final VoidCallback onNewQuote;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Bookmark Button
          _ActionButton(
            icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            onTap: onBookmark,
          ),
          // Share Button
          _ActionButton(icon: Icons.share, onTap: onShare),
          // New Quote Button
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              height: 56,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Material(
                color: colorScheme.surface.withValues(alpha: 0),
                child: InkWell(
                  onTap: onNewQuote,
                  borderRadius: BorderRadius.circular(16),
                  child: Center(
                    child: Text(
                      'New Quote',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: colorScheme.surface.withValues(alpha: 0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Icon(icon, color: colorScheme.onSurface, size: 24),
        ),
      ),
    );
  }
}
