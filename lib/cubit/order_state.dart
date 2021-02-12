part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderListLoaded extends OrderState {
  final List<Order> order;

  OrderListLoaded(this.order);

  @override
  List<Object> get props => [order];
}

class OrderLoaded extends OrderState {
  final Order order;

  OrderLoaded(this.order);

  @override
  List<Object> get props => [order];
}

class OrderLoadFailed extends OrderState {
  final String message;

  OrderLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
