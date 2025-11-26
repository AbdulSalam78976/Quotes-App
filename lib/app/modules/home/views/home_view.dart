import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.surface,
                    colorScheme.surfaceContainerHighest,
                  ],
                ),
              ),
            ),
            Column(
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
                        'ZenQuote',
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: colorScheme.onSecondaryContainer,
                            size: 28,
                          ),
                          onPressed: () {
                            // TODO: Open drawer/menu
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.1,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return _CategoryCard(
                          category: category,
                          onTap: () => controller.onCategoryTap(category),
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(
                () => _CustomFloatingNavBar(
                  currentIndex: controller.currentIndex.value,
                  onIndexChanged: controller.changeBottomNavIndex,
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomFloatingNavBar extends StatelessWidget {
  const _CustomFloatingNavBar({
    required this.currentIndex,
    required this.onIndexChanged,
    required this.colorScheme,
    required this.textTheme,
  });

  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home,
              label: 'Home',
              isSelected: currentIndex == 0,
              onTap: () => onIndexChanged(0),
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
            _NavItem(
              icon: Icons.search,
              label: 'Discover',
              isSelected: currentIndex == 1,
              onTap: () => onIndexChanged(1),
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
            _NavItem(
              icon: Icons.bookmark,
              label: 'Saved',
              isSelected: currentIndex == 2,
              onTap: () => onIndexChanged(2),
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
            _NavItem(
              icon: Icons.person,
              label: 'Profile',
              isSelected: currentIndex == 3,
              onTap: () => onIndexChanged(3),
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.onTap,
    required this.colorScheme,
    required this.textTheme,
  });

  final Category category;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final accent = Color(category.color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colorScheme.outline),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(category.icon, size: 32, color: accent),
            ),
            const SizedBox(height: 12),
            Text(
              category.name,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
    required this.textTheme,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
              size: 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
