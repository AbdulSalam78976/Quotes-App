import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/quote_model.dart';
import '../../quote_detail/bindings/quote_detail_binding.dart';
import '../../quote_detail/views/quote_detail_view.dart';
import '../controllers/quotes_list_controller.dart';

class QuotesListView extends GetView<QuotesListController> {
  const QuotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.categoryName.isEmpty ? 'Wisdom' : controller.categoryName,
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
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
                  onPressed: controller.fetchQuotes,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        if (controller.quotes.isEmpty) {
          return Center(
            child: Text(
              'No quotes found',
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.quotes.length,
          itemBuilder: (context, index) {
            final quote = controller.quotes[index];
            return _QuoteCard(
              quote: quote,
              index: index,
              isLiked: controller.isLiked(quote.id),
              onLike: () => controller.toggleLike(quote.id),
              onRefresh: () => controller.refreshQuote(index),
              onShare: () => controller.shareQuote(quote),
              onTap: () {
                Get.to(
                  () => const QuoteDetailView(),
                  binding: QuoteDetailBinding(),
                  arguments: quote,
                );
              },
            );
          },
        );
      }),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({
    required this.quote,
    required this.index,
    required this.isLiked,
    required this.onLike,
    required this.onRefresh,
    required this.onShare,
    required this.onTap,
  });

  final Quote quote;
  final int index;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onRefresh;
  final VoidCallback onShare;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quote.content,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '— ${quote.author}',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ActionButton(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  onTap: onLike,
                ),
                const SizedBox(width: 12),
                _ActionButton(
                  icon: Icons.refresh,
                  color: colorScheme.onSurfaceVariant,
                  onTap: onRefresh,
                ),
                const SizedBox(width: 12),
                _ActionButton(
                  icon: Icons.share,
                  color: colorScheme.onSurfaceVariant,
                  onTap: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
