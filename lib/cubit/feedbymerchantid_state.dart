part of 'feedbymerchantid_cubit.dart';

abstract class FeedbymerchantidState extends Equatable {
  const FeedbymerchantidState();

  @override
  List<Object> get props => [];
}

class FeedbymerchantidInitial extends FeedbymerchantidState {}


class FeedByIdMerchantListLoaded extends FeedbymerchantidState {
  final List<Feed> feed;

  FeedByIdMerchantListLoaded(this.feed);

  @override
  List<Object> get props => [feed];
}

class FeedByMerchantIdFailed extends FeedbymerchantidState {
  final String message;

  FeedByMerchantIdFailed(this.message);

  @override
  List<Object> get props => [message];
}