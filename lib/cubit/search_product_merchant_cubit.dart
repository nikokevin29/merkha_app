import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'search_product_merchant_state.dart';

class SearchProductMerchantCubit extends Cubit<SearchProductMerchantState> {
  SearchProductMerchantCubit() : super(SearchProductMerchantInitial());

  Future<void> searchFilterProductMerchant({String keyword, String idMerchant}) async {
    ApiReturnValue<List<Product>> result = await ProductServices.searchProductByMerchant(
      id: idMerchant,
      productName: keyword,
    );
    if (result.value != null) {
      emit(SearchProductMerchantLoaded(result.value));
      print('Search Product By Merchant Getted');
    } else {
      emit(SearchProductMerchantLoadingFailed(result.message));
    }
  }

  Future<void> clear() async {
    emit(SearchProductMerchantLoaded([]));
  }
}
