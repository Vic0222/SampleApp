import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/exceptions/http_exception.dart';
import 'package:sample_app/services/hacker_news_service.dart';

import 'top_news_list_event.dart';
import 'top_news_list_state.dart';

class TopNewsListBloc extends Bloc<TopNewsListEvent, TopNewsListState> {
  final HackerNewsService _hackerNewsService;

  TopNewsListBloc(this._hackerNewsService)
      : super(const TopNewsListState.loadInitial()) {
    on<TopNewsListLoadStarted>(_onTopNewsListLoadStarted);
  }

  FutureOr<void> _onTopNewsListLoadStarted(
      TopNewsListLoadStarted event, Emitter<TopNewsListState> emit) async {
    try {
      emit.call(const TopNewsListState.loadInProgress());

      var topNewsIds = await _hackerNewsService.getTopNewsId();

      emit.call(TopNewsListState.loadSuccess(topNewsIds));
    } on HttpException catch (ex) {
      emit.call(TopNewsListState.loadFailure(
          "${ex.message} - Error Code ${ex.statusCode}"));
    } catch (ex) {
      emit.call(TopNewsListState.loadFailure(ex.toString()));
    }
  }

  void loadTopNews() {
    add(const TopNewsListLoadStarted());
  }
}
