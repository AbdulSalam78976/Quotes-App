import 'package:get/get.dart';

import '../../../data/services/quote_service.dart';
import '../controllers/quotes_list_controller.dart';

class QuotesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuoteService>(() => QuoteService());
    Get.put(QuotesListController(service: Get.find<QuoteService>()));
  }
}
