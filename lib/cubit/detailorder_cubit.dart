import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'detailorder_state.dart';

class DetailorderCubit extends Cubit<DetailorderState> {
  DetailorderCubit() : super(DetailorderInitial());

  Future<void> showDetailOrder(String idOrder) async {
    ApiReturnValue<List<DetailOrder>> result =
        await OrderServices.showDetailOrder(idOrder: idOrder);
    if (result.value != null) {
      emit(DetailOrderListLoaded(result.value));
    } else {
      emit(DetailOrderFailed(result.message));
    }
  }

Future<void> clear() async {
    emit(DetailOrderListLoaded([]));
  }
}
