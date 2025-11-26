import 'package:get/get.dart';

import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 1), navigateToHome);
  }

  void navigateToHome() {
    Get.offAll(() => const HomeView(), binding: HomeBinding());
  }
}
