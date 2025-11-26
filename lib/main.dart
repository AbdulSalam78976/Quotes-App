import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/splash/bindings/splash_binding.dart';
import 'app/modules/splash/views/splash_view.dart';
import 'app/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuotesApp());
}

class QuotesApp extends StatelessWidget {
  const QuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ZenQuote',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialBinding: SplashBinding(),
      home: const SplashView(),
    );
  }
}
