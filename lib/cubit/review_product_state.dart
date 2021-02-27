part of 'review_product_cubit.dart';

abstract class ReviewProductState extends Equatable {
  const ReviewProductState();

  @override
  List<Object> get props => [];
}

class ReviewProductInitial extends ReviewProductState {}


class ReviewProductLoaded extends ReviewProductState {
  final List<ReviewProduct> review;

  ReviewProductLoaded(this.review);

  @override
  List<Object> get props => [review];
}
class ReviwProductLoadingFailed extends ReviewProductState {
  final String message;

  ReviwProductLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}