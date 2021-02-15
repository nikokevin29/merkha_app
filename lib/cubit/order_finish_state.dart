part of 'order_finish_cubit.dart';

abstract class OrderFinishState extends Equatable {
  const OrderFinishState();

  @override
  List<Object> get props => [];
}

class OrderFinishInitial extends OrderFinishState {}

class OrderFinishListLoaded extends OrderFinishState {
  final List<Order> order;

  OrderFinishListLoaded(this.order);

  @override
  List<Object> get props => [order];
}

class OrderFinishLoaded extends OrderFinishState {
  final Order order;

  OrderFinishLoaded(this.order);

  @override
  List<Object> get props => [order];
}

class OrderFinishLoadFailed extends OrderFinishState {
  final String message;

  OrderFinishLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}