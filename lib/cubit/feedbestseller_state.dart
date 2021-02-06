part of 'feedbestseller_cubit.dart';

abstract class FeedbestsellerState extends Equatable {
  const FeedbestsellerState();

  @override
  List<Object> get props => [];
}

class FeedbestsellerInitial extends FeedbestsellerState {}

class FeedByBestSellerListLoaded extends FeedbestsellerState {
  final List<Feed> feed;

  FeedByBestSellerListLoaded(this.feed);

  @override
  List<Object> get props => [feed];
}

class FeedByBestSellerFailed extends FeedbestsellerState {
  final String message;

  FeedByBestSellerFailed(this.message);

  @override
  List<Object> get props => [message];
}