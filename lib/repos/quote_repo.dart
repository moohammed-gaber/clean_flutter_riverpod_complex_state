import 'package:riverpod_test/models/quote.dart';
import 'package:dio/dio.dart';

abstract class IQuoteRepo {
  Future<List<Quote>> getQuotes();
}

class QuoteRepo implements IQuoteRepo {
  QuoteRepo(this.dio);

  final Dio dio;

  @override
  Future<List<Quote>> getQuotes() async {
    final result = await dio.get('https://dummyjson.com/quotes');
    return (result.data['quotes'] as List)
        .map((e) => Quote.fromMap(e))
        .toList();
  }
}
