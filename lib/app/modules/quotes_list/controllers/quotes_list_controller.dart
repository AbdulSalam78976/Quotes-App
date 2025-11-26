import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/quote_model.dart';
import '../../../data/services/quote_service.dart';

class QuotesListController extends GetxController {
  QuotesListController({required QuoteService service}) : _service = service;

  final QuoteService _service;

  final RxList<Quote> quotes = <Quote>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxSet<String> likedQuotes = <String>{}.obs;

  String categoryName = '';
  String categoryTag = '';

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      categoryName = args['name'] as String? ?? '';
      categoryTag = args['tag'] as String? ?? '';
    }
    fetchQuotes();
  }

  Future<void> fetchQuotes() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final results = await _service.fetchQuotesByTag(categoryTag, limit: 20);
      quotes.value = results;
    } on QuoteApiException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleLike(String quoteId) {
    if (likedQuotes.contains(quoteId)) {
      likedQuotes.remove(quoteId);
    } else {
      likedQuotes.add(quoteId);
    }
  }

  bool isLiked(String quoteId) => likedQuotes.contains(quoteId);

  Future<void> shareQuote(Quote quote) async {
    final shareContent =
        '"${quote.content}" — ${quote.author}\n#Quotes #Inspiration';
    await Share.share(shareContent);
  }

  Future<void> refreshQuote(int index) async {
    try {
      final newQuote = await _service.fetchRandomQuote();
      if (index < quotes.length) {
        quotes[index] = newQuote;
      }
    } catch (_) {
      // Silently fail for refresh
    }
  }
}
