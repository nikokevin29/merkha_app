import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'product_state.dart';

//Discover
class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> showProductDiscover({String limit}) async {
    ApiReturnValue<List<Product>> result = await ProductServices.showProductDiscover(limit: limit);
    if (result.value != null) {
      emit(ProductListLoaded(result.value));
      print('Discover Loaded');
    } else {
      emit(ProductLoadingFailed(result.message));
    }
  }
}
