part of 'merchantcategory_cubit.dart';

abstract class MerchantcategoryState extends Equatable {
  const MerchantcategoryState();

  @override
  List<Object> get props => [];
}

class MerchantcategoryInitial extends MerchantcategoryState {}

class MerchantCategoryListLoaded extends MerchantcategoryState {
  final List<MerchantCategory> merchantCategory;

  MerchantCategoryListLoaded(this.merchantCategory);

  @override
  List<Object> get props => [merchantCategory];
}

class MerchantCategoryLoadingFailed extends MerchantcategoryState {
  final String message;

  MerchantCategoryLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
