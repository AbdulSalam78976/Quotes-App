import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../quotes_list/bindings/quotes_list_binding.dart';
import '../../quotes_list/views/quotes_list_view.dart';

class Category {
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  final String id;
  final String name;
  final IconData icon;
  final int color;
}

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<Category> categories = [
    Category(
      id: 'motivation',
      name: 'Motivation',
      icon: Icons.rocket_launch,
      color: 0xFF9C27B0, // Purple
    ),
    Category(
      id: 'success',
      name: 'Success',
      icon: Icons.emoji_events,
      color: 0xFFFF9800, // Orange
    ),
    Category(
      id: 'love',
      name: 'Love',
      icon: Icons.favorite,
      color: 0xFFE91E63, // Pink/Red
    ),
    Category(
      id: 'life',
      name: 'Life',
      icon: Icons.eco,
      color: 0xFF00BCD4, // Teal/Cyan
    ),
    Category(
      id: 'study',
      name: 'Study',
      icon: Icons.school,
      color: 0xFF2196F3, // Blue
    ),
    Category(
      id: 'fitness',
      name: 'Fitness',
      icon: Icons.fitness_center,
      color: 0xFFCDDC39, // Lime Green
    ),
    Category(
      id: 'happiness',
      name: 'Happiness',
      icon: Icons.sentiment_very_satisfied,
      color: 0xFFFFEB3B, // Yellow
    ),
    Category(
      id: 'business',
      name: 'Business',
      icon: Icons.business,
      color: 0xFF607D8B, // Dark Grey/Blue
    ),
  ];

  void changeBottomNavIndex(int index) {
    currentIndex.value = index;
  }

  void onCategoryTap(Category category) {
    Get.to(
      () => const QuotesListView(),
      binding: QuotesListBinding(),
      arguments: {'name': category.name, 'tag': category.id},
    );
  }
}
