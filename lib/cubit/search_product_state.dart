part of 'search_product_cubit.dart';

abstract class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object> get props => [];
}

class SearchProductInitial extends SearchProductState {}


class SearchProductLoaded extends SearchProductState {
  final List<Product> product;

  SearchProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}
class SearchProductLoadingFailed extends SearchProductState {
  final String message;

  SearchProductLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}