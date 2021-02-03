import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'productbymerchatcat_state.dart';

class ProductbymerchatcatCubit extends Cubit<ProductbymerchatcatState> {
  ProductbymerchatcatCubit() : super(ProductbymerchatcatInitial());

  Future<void> showMerchantCategorybyId({String id}) async {
    ApiReturnValue<List<Product>> result = await ProductServices.showMerchantCategorybyId(id: id);
    if (result.value != null) {
      emit(ProductByMerchantCatIdListLoaded(result.value));
      print('ProductByMerchantCatIdListLoaded Loaded');
    } else {
      emit(ProductByMerchantCatLoadingFailed(result.message));
    }
  }
}
