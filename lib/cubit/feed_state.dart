part of 'feed_cubit.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}

class FeedListLoaded extends FeedState {
  final List<Feed> feed;
  final bool hasReachedMax;

  FeedListLoaded({this.feed, this.hasReachedMax});

  FeedListLoaded copyWith({List<Feed> feed, bool hasReachedMax}) {
    return FeedListLoaded(
      feed: feed ?? this.feed,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

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
