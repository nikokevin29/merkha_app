part of 'merchantbyid_cubit.dart';

abstract class MerchantbyidState extends Equatable {
  const MerchantbyidState();

  @override
  List<Object> get props => [];
}

class MerchantbyidInitial extends MerchantbyidState {}


class MerchantByIdoadingFailed extends MerchantbyidState {
  final String message;

  MerchantByIdoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class MerchantByIdLoaded extends MerchantbyidState {
  final Merchant merchant;

  MerchantByIdLoaded(this.merchant);

  @override
  List<Object> get props => [merchant];
}
