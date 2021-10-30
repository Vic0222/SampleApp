import 'package:equatable/equatable.dart';

abstract class TopNewsListEvent extends Equatable {
  const TopNewsListEvent();

  @override
  List<Object> get props => [];
}

class TopNewsListLoadStarted extends TopNewsListEvent {
  const TopNewsListLoadStarted();
}
