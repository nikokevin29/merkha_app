import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'merchantcategory_state.dart';

class MerchantcategoryCubit extends Cubit<MerchantcategoryState> {
  MerchantcategoryCubit() : super(MerchantcategoryInitial());

  Future<void> showAllMerchantCategory() async {
    ApiReturnValue<List<MerchantCategory>> result = await MerchantService.showAllMerchantCategory();
    if (result.value != null) {
      emit(MerchantCategoryListLoaded(result.value));
    } else {
      emit(MerchantCategoryLoadingFailed(result.message));
    }
  }
}
