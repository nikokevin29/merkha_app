part of 'product_by_category_cubit.dart';

abstract class ProductByCategoryState extends Equatable {
  const ProductByCategoryState();

  @override
  List<Object> get props => [];
}

class ProductByCategoryInitial extends ProductByCategoryState {}

class ProductByCategoryListLoaded extends ProductByCategoryState {
  final List<Product> product;

  ProductByCategoryListLoaded(this.product);

  @override
  List<Object> get props => [product];
}
class ProductByCategoryLoadingFailed extends ProductByCategoryState {
  final String message;

  ProductByCategoryLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}