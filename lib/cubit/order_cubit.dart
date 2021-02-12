import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  Future<void> createOrder(Order order) async {
    ApiReturnValue<Order> result = await OrderServices.createOrder(order: order);
    if (result.value != null) {
      SharedPreferences orders = await SharedPreferences.getInstance();
      await orders.setInt('lastId', result.value.id);
      emit(OrderLoaded(result.value));
    } else {
      emit(OrderLoadFailed(result.message));
    }
  }
}
