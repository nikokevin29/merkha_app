part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

// class ProducLoaded extends AddressState {
//   final Address address;

//   AddressLoaded(this.address);

//   @override
//   List<Object> get props => [address];
// }
class ProductListLoaded extends ProductState {
  final List<Product> product;

  ProductListLoaded(this.product);

  @override
  List<Object> get props => [product];
}
class ProductLoadingFailed extends ProductState {
  final String message;

  ProductLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}