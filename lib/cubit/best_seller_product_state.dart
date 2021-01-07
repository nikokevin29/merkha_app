part of 'best_seller_product_cubit.dart';

abstract class BestSellerProductState extends Equatable {
  const BestSellerProductState();

  @override
  List<Object> get props => [];
}

class BestSellerProductInitial extends BestSellerProductState {}

class BestSellerProductListLoaded extends BestSellerProductState {
  final List<Product> product;

  BestSellerProductListLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class BestSellerProductLoadingFailed extends BestSellerProductState {
  final String message;

  BestSellerProductLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
