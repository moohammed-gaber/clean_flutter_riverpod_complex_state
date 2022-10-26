import 'package:riverpod_test/models/quote.dart';
import 'package:riverpod_test/repos/quote_repo.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/repos/auth_repo.dart';
import 'package:riverpod_test/exceptions/exceptions.dart';
import 'package:riverpod_test/view_models/state.dart';
import 'package:riverpod_test/view_models/view_model.dart';


final authProvider =
Provider<IAuthRepo>((ref) => AuthRepo(ref.read(dioClientProvider)));

final stateProvider = StateNotifierProvider<ViewModel, ViewModelState>(
        (ref) => ViewModel(ref.read(authProvider)));

final dioClientProvider = Provider<Dio>((ref) => (Dio()));
final repoProvider =
Provider<IQuoteRepo>((ref) => QuoteRepo((ref.read(dioClientProvider))));

final quotesProvider = FutureProvider<List<Quote>>((ref) {
  return ref.read(repoProvider).getQuotes();
});
