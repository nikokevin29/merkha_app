import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'order_finish_state.dart';

class OrderFinishCubit extends Cubit<OrderFinishState> {
  OrderFinishCubit() : super(OrderFinishInitial());
  Future<void> showFinishedOrder() async {
    ApiReturnValue<List<Order>> result = await OrderServices.showFinishedOrder();
    if (result.value != null) {
      emit(OrderFinishListLoaded(result.value));
    } else {
      emit(OrderFinishLoadFailed(result.message));
    }
  }
}
