import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/quote_model.dart';
import '../../../data/services/quote_service.dart';

class QuoteController extends GetxController {
  QuoteController({required QuoteService service}) : _service = service;

  final QuoteService _service;

  final Rxn<Quote> quote = Rxn<Quote>();
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
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

  Future<void> shareQuote() async {
    final currentQuote = quote.value;
    if (currentQuote == null) return;

    final shareContent =
        '"${currentQuote.content}" — ${currentQuote.author}\n#Quotes #Inspiration';
    await Share.share(shareContent);
  }
}
