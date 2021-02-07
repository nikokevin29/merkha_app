part of 'search_product_merchant_cubit.dart';

abstract class SearchProductMerchantState extends Equatable {
  const SearchProductMerchantState();

  @override
  List<Object> get props => [];
}

class SearchProductMerchantInitial extends SearchProductMerchantState {}

class SearchProductMerchantLoaded extends SearchProductMerchantState {
  final List<Product> product;

  SearchProductMerchantLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class SearchProductMerchantLoadingFailed extends SearchProductMerchantState {
  final String message;

  SearchProductMerchantLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
