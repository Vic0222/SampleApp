import 'package:equatable/equatable.dart';
import 'package:sample_app/models/news.dart';

enum NewsStatus {
  loadInitial,
  loadInProgress,
  loadSuccess,
  loadFailure,
}

class NewsState extends Equatable {
  const NewsState._({
    this.status = NewsStatus.loadInitial,
    this.news = News.empty,
    this.errorMessage = "",
  });

  const NewsState.loadInitial() : this._();

  const NewsState.loadInProgress() : this._(status: NewsStatus.loadInProgress);

  const NewsState.loadSuccess(News news)
      : this._(status: NewsStatus.loadSuccess, news: news);

  const NewsState.loadFailure(String errorMessage)
      : this._(status: NewsStatus.loadFailure, errorMessage: errorMessage);

  final NewsStatus status;
  final String errorMessage;
  final News news;

  @override
  List<Object> get props => [status, errorMessage, news];
}
