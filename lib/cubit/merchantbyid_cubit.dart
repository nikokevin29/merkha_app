import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'merchantbyid_state.dart';

class MerchantbyidCubit extends Cubit<MerchantbyidState> {
  MerchantbyidCubit() : super(MerchantbyidInitial());

  Future<void> showMerchantById({String id}) async {
    ApiReturnValue<Merchant> result = await MerchantService.showByMerchantId(merchantId: id);
    if (result.value != null) {
      emit(MerchantByIdLoaded(result.value));
    } else {
      emit(MerchantByIdoadingFailed(result.message));
    }
  }
}
