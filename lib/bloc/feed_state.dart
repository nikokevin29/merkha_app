part of 'feed_bloc.dart';

abstract class FeedStates extends Equatable {
  const FeedStates();

  @override
  List<Object> get props => [];

}

class FeedInitials extends FeedStates {}

class FeedFailure extends FeedStates {}

class FeedSuccess extends FeedStates {
  final List<Feed> feed;
  final bool hasReachedMax;

  const FeedSuccess({
    this.feed,
    this.hasReachedMax,
  });

  FeedSuccess copyWith({
    List<Feed> feed,
    bool hasReachedMax,
  }) {
    return FeedSuccess(
      feed: feed ?? this.feed,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [feed, hasReachedMax];

  @override
  String toString() => 'FeedSuccess { feed: ${feed.length}, hasReachedMax: $hasReachedMax }';
}
