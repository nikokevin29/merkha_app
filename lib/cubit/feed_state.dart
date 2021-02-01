part of 'feed_cubit.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}


class FeedListLoaded extends FeedState {
  final List<Feed> feed;

  FeedListLoaded(this.feed);

  @override
  List<Object> get props => [feed];
}

// class OwnFeedListLoaded extends FeedState {
//   final List<Feed> feed;

//   OwnFeedListLoaded(this.feed);

//   @override
//   List<Object> get props => [feed];
// }

class FeedLoaded extends FeedState {
  final Feed feed;

  FeedLoaded(this.feed);

  @override
  List<Object> get props => [feed];
}

class FeedFailed extends FeedState {
  final String message;

  FeedFailed(this.message);

  @override
  List<Object> get props => [message];
}
