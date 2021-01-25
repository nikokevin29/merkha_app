part of 'voucher_cubit.dart';

abstract class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object> get props => [];
}

class VoucherInitial extends VoucherState {}


class VoucherLoaded extends VoucherState {
  final List<Voucher> voucher;

  VoucherLoaded(this.voucher);

  @override
  List<Object> get props => [voucher];
}

class VoucherUsed extends VoucherState {
  final Voucher voucher;

  VoucherUsed(this.voucher);

  @override
  List<Object> get props => [voucher];
}

class VoucherLoadingFailed extends VoucherState {
  final String message;

  VoucherLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}