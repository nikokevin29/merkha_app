part of 'search_merchant_cubit.dart';

abstract class SearchMerchantState extends Equatable {
  const SearchMerchantState();

  @override
  List<Object> get props => [];
}

class SearchMerchantInitial extends SearchMerchantState {}

class SearchMerchantLoaded extends SearchMerchantState {
  final List<Merchant> merchant;

  SearchMerchantLoaded(this.merchant);

  @override
  List<Object> get props => [merchant];
}
class SearchMerchantLoadingFailed extends SearchMerchantState {
  final String message;

  SearchMerchantLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}