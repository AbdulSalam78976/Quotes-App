import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/quote_model.dart';

class QuoteService {
  QuoteService({http.Client? client}) : _client = client ?? http.Client();

  static const _baseUrl = 'https://api.quotable.io';

  final http.Client _client;

  Future<Quote> fetchRandomQuote() async {
    final uri = Uri.parse('$_baseUrl/random');

    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(response.body) as Map<String, dynamic>;
        return Quote.fromJson(data);
      }

      throw QuoteApiException(
        message: 'Failed to load quote (${response.statusCode}).',
      );
    } on SocketException {
      throw QuoteApiException(
        message: 'No internet connection. Please check your network.',
      );
    } on FormatException {
      throw QuoteApiException(
        message: 'Received malformed data. Please try again soon.',
      );
    } catch (_) {
      throw QuoteApiException(
        message: 'Unexpected error occurred. Please try again.',
      );
    }
  }
}

class QuoteApiException implements Exception {
  QuoteApiException({required this.message});

  final String message;

  @override
  String toString() => 'QuoteApiException: $message';
}
