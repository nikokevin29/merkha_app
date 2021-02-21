import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit() : super(VoucherInitial());

  Future<void> showAllVoucher() async {
    ApiReturnValue<List<Voucher>> result = await VoucherServices.showVoucher();
    if (result.value != null) {
      emit(VoucherLoaded(result.value));
    } else {
      emit(VoucherLoadingFailed(result.message));
    }
  }

  // Future<void> useVoucher(String code) async {
  //   ApiReturnValue<Voucher> result = await VoucherServices.useVoucher(code: code);
  //   if (result.value != null) {
  //     emit(VoucherUsed(result.value));
  //   } else {
  //     emit(VoucherLoadingFailed(result.message));
  //   }
  // }

  Future<void> checkVoucher(String id, int idMerch) async {
    ApiReturnValue<Voucher> result = await VoucherServices.checkVoucher(id: id);
    if (result.value == null) {
      emit(VoucherLoadingFailed(result.message));
    } else if (result.value.idMerchant == idMerch) {
      print('Voucher Valid');
      emit(VoucherUsed(result.value));
    } else {
      print("Can't use voucher from another Merchant");
      emit(VoucherLoadingFailed("Can't use voucher from another Merchant"));
    }
  }

  Future<void> clear() async {
    emit(VoucherLoadingFailed(''));
  }
}
