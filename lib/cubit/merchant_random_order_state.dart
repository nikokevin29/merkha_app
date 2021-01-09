part of 'merchant_random_order_cubit.dart';

abstract class MerchantRandomOrderState extends Equatable {
  const MerchantRandomOrderState();

  @override
  List<Object> get props => [];
}

class MerchantRandomOrderInitial extends MerchantRandomOrderState {}


class MerchantByRandomListLoaded extends MerchantRandomOrderState {
  final List<Merchant> merchant;

  MerchantByRandomListLoaded(this.merchant);

  @override
  List<Object> get props => [merchant];
}
class MerchantByRandomLoadingFailed extends MerchantRandomOrderState {
  final String message;

  MerchantByRandomLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}