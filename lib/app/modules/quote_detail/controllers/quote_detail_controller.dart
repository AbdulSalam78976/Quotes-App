import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/quote_model.dart';
import '../../../data/services/quote_service.dart';

class QuoteDetailController extends GetxController {
  QuoteDetailController({required QuoteService service}) : _service = service;

  final QuoteService _service;

  final Rxn<Quote> quote = Rxn<Quote>();
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isBookmarked = false.obs;

  @override
  void onInit() {
    super.onInit();
    final quoteArg = Get.arguments;
    if (quoteArg is Quote) {
      quote.value = quoteArg;
      isLoading.value = false;
    } else {
      fetchRandomQuote();
    }
  }

  Future<void> fetchRandomQuote() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _service.fetchRandomQuote();
      quote.value = result;
    } on QuoteApiException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
  }

  Future<void> shareQuote() async {
    final currentQuote = quote.value;
    if (currentQuote == null) return;

    final shareContent =
        '"${currentQuote.content}" — ${currentQuote.author}\n#Quotes #Inspiration';
    await Share.share(shareContent);
  }
}
