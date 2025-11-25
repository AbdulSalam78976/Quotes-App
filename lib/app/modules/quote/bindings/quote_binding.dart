import 'package:get/get.dart';

import '../../../data/services/quote_service.dart';
import '../controllers/quote_controller.dart';

class QuoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuoteService>(() => QuoteService());
    Get.put(QuoteController(service: Get.find<QuoteService>()));
  }
}
