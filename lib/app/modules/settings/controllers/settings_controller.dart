import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final RxBool isDarkMode = true.obs;
  final RxBool isDailyReminder = false.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleDailyReminder() {
    isDailyReminder.value = !isDailyReminder.value;
    // TODO: Implement daily reminder logic
  }

  void navigateToAbout() {
    // TODO: Navigate to about screen
  }

  void navigateToPrivacyPolicy() {
    // TODO: Navigate to privacy policy screen
  }
}
