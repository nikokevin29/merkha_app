part of 'review_merchant_cubit.dart';

abstract class ReviewMerchantState extends Equatable {
  const ReviewMerchantState();

  @override
  List<Object> get props => [];
}

class ReviewMerchantInitial extends ReviewMerchantState {}


class ReviewMerchantLoaded extends ReviewMerchantState {
  final List<ReviewMerchant> reviewMerchant;

  ReviewMerchantLoaded(this.reviewMerchant);

  @override
  List<Object> get props => [reviewMerchant];
}
class ReviwMerchantLoadingFailed extends ReviewMerchantState {
  final String message;

  ReviwMerchantLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}