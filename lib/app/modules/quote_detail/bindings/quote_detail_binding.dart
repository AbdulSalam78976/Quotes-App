import 'package:get/get.dart';

import '../../../data/services/quote_service.dart';
import '../controllers/quote_detail_controller.dart';

class QuoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuoteService>(() => QuoteService());
    Get.put(QuoteDetailController(service: Get.find<QuoteService>()));
  }
}
