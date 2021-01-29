import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'search_product_state.dart';

class SearchProductCubit extends Cubit<SearchProductState> {
  SearchProductCubit() : super(SearchProductInitial());

  Future<void> searchFilterProduct({String keyword}) async {
    ApiReturnValue<List<Product>> result =
        await ProductServices.searchFilterProduct(keyword: keyword);
    if (result.value != null) {
      emit(SearchProductLoaded(result.value));
      print('Search Fetched');
    } else {
      emit(SearchProductLoadingFailed(result.message));
    }
  }

  Future<void> clear() async {
    emit(SearchProductLoaded([]));
  }
}
