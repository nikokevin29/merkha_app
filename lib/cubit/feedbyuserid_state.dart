part of 'feedbyuserid_cubit.dart';

abstract class FeedbyuseridState extends Equatable {
  const FeedbyuseridState();

  @override
  List<Object> get props => [];
}

class FeedbyuseridInitial extends FeedbyuseridState {}

class FeedByUserIdListLoaded extends FeedbyuseridState {
  final List<Feed> feed;

  FeedByUserIdListLoaded(this.feed);

  @override
  List<Object> get props => [feed];
}

class FeedByUserIdFailed extends FeedbyuseridState {
  final String message;

  FeedByUserIdFailed(this.message);

  @override
  List<Object> get props => [message];
}