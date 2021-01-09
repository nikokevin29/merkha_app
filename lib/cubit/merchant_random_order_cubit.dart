import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'merchant_random_order_state.dart';

class MerchantRandomOrderCubit extends Cubit<MerchantRandomOrderState> {
  MerchantRandomOrderCubit() : super(MerchantRandomOrderInitial());

  Future<void> showMerchantByRandom({String limit}) async {
    ApiReturnValue<List<Merchant>> result =
        await MerchantService.showMerchantByRandom(limit: limit);
    if (result.value != null) {
      emit(MerchantByRandomListLoaded(result.value));
    } else {
      emit(MerchantByRandomLoadingFailed(result.message));
    }
  }
}
