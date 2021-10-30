import 'package:equatable/equatable.dart';

enum TopNewsListStatus {
  loadInitial,
  loadInProgress,
  loadSuccess,
  loadFailure,
}

class TopNewsListState extends Equatable {
  const TopNewsListState._({
    this.status = TopNewsListStatus.loadInitial,
    this.topNewsIds = const <int>[],
    this.errorMessage = "",
  });

  const TopNewsListState.loadInitial() : this._();

  const TopNewsListState.loadInProgress()
      : this._(status: TopNewsListStatus.loadInProgress);

  const TopNewsListState.loadSuccess(List<int> topNewsIds)
      : this._(status: TopNewsListStatus.loadSuccess, topNewsIds: topNewsIds);

  const TopNewsListState.loadFailure(String errorMessage)
      : this._(
            status: TopNewsListStatus.loadFailure, errorMessage: errorMessage);

  final TopNewsListStatus status;
  final String errorMessage;
  final List<int> topNewsIds;

  @override
  List<Object> get props => [status, errorMessage, topNewsIds];
}
