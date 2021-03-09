part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class FeedFetched extends FeedEvent {}

class FeedRefresh extends FeedEvent {}
