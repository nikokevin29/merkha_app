import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'productbymerchant_state.dart';

class ProductbymerchantCubit extends Cubit<ProductbymerchantState> {
  ProductbymerchantCubit() : super(ProductbymerchantInitial());

  Future<void> showProductByMerchant({String id}) async {
    ApiReturnValue<List<Product>> result =
        await ProductServices.showProductbyMerchant(idMerhcant: id);
    if (result.value != null) {
      emit(ProductByMerchantListLoaded(result.value));
    } else {
      emit(ProductByMerchantLoadingFailed(result.message));
    }
  }
}
