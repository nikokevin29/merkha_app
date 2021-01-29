import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'search_merchant_state.dart';

class SearchMerchantCubit extends Cubit<SearchMerchantState> {
  SearchMerchantCubit() : super(SearchMerchantInitial());

  Future<void> searchFilterMerchant({String keyword}) async {
    ApiReturnValue<List<Merchant>> result = await MerchantService.searchFilterMerchant(keyword: keyword);
    if (result.value != null) {
      emit(SearchMerchantLoaded(result.value));
      print('Search Merchant Fetched');
    } else {
      emit(SearchMerchantLoadingFailed(result.message));
    }
  }
  Future<void> clear() async {
    emit(SearchMerchantLoaded([]));
  }
  
}
