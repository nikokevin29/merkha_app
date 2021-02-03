part of 'productbymerchatcat_cubit.dart';

abstract class ProductbymerchatcatState extends Equatable {
  const ProductbymerchatcatState();

  @override
  List<Object> get props => [];
}

class ProductbymerchatcatInitial extends ProductbymerchatcatState {}

class ProductByMerchantCatIdListLoaded extends ProductbymerchatcatState {
  final List<Product> product;

  ProductByMerchantCatIdListLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class ProductByMerchantCatLoadingFailed extends ProductbymerchatcatState {
  final String message;

  ProductByMerchantCatLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
