part of 'feedbymerchantcategory_cubit.dart';

abstract class FeedbymerchantcategoryState extends Equatable {
  const FeedbymerchantcategoryState();

  @override
  List<Object> get props => [];
}

class FeedbymerchantcategoryInitial extends FeedbymerchantcategoryState {}


class FeedByMerchantCatListLoaded extends FeedbymerchantcategoryState {
  final List<Feed> feed;

  FeedByMerchantCatListLoaded(this.feed);

  @override
  List<Object> get props => [feed];
}

class FeedByMerchantCatFailed extends FeedbymerchantcategoryState {
  final String message;

  FeedByMerchantCatFailed(this.message);

  @override
  List<Object> get props => [message];
}