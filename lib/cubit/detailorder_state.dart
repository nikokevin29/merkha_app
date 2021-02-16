part of 'detailorder_cubit.dart';

abstract class DetailorderState extends Equatable {
  const DetailorderState();

  @override
  List<Object> get props => [];
}

class DetailorderInitial extends DetailorderState {}

class DetailOrderListLoaded extends DetailorderState {
  final List<DetailOrder> detailOrder;

  DetailOrderListLoaded(this.detailOrder);

  @override
  List<Object> get props => [detailOrder];
}

class DetailOrderFailed extends DetailorderState {
  final String message;

  DetailOrderFailed(this.message);

  @override
  List<Object> get props => [message];
}