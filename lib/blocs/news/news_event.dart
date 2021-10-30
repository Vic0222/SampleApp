import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class NewsLoadStarted extends NewsEvent {
  final int id;
  const NewsLoadStarted(this.id);
}
