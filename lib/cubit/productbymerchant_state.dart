part of 'productbymerchant_cubit.dart';

abstract class ProductbymerchantState extends Equatable {
  const ProductbymerchantState();

  @override
  List<Object> get props => [];
}

class ProductbymerchantInitial extends ProductbymerchantState {}

class ProductByMerchantListLoaded extends ProductbymerchantState {
  final List<Product> product;

  ProductByMerchantListLoaded(this.product);

  @override
  List<Object> get props => [product];
}
class ProductByMerchantLoadingFailed extends ProductbymerchantState {
  final String message;

  ProductByMerchantLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}