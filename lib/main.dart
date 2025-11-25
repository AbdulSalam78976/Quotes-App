import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/quote/bindings/quote_binding.dart';
import 'app/modules/quote/views/quote_view.dart';
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
      title: 'Quotes App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialBinding: QuoteBinding(),
      home: const QuoteView(),
    );
  }
}
