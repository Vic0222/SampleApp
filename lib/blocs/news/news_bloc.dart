import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/blocs/news/news_state.dart';
import 'package:sample_app/exceptions/http_exception.dart';
import 'package:sample_app/services/hacker_news_service.dart';

import 'news_event.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final HackerNewsService _hackerNewsService;

  NewsBloc(this._hackerNewsService) : super(const NewsState.loadInitial()) {
    on<NewsLoadStarted>(_onTopNewsListLoadStarted);
  }

  FutureOr<void> _onTopNewsListLoadStarted(
      NewsLoadStarted event, Emitter<NewsState> emit) async {
    try {
      emit.call(const NewsState.loadInProgress());

      var news = await _hackerNewsService.getNews(event.id);

      emit.call(NewsState.loadSuccess(news));
    } on HttpException catch (ex) {
      emit.call(
          NewsState.loadFailure("${ex.message} - Error Code ${ex.statusCode}"));
    } catch (ex) {
      debugPrint(ex.toString());
      emit.call(const NewsState.loadFailure("There was an unknow error."));
    }
  }

  void loadNews(int id) {
    add(NewsLoadStarted(id));
  }
}
