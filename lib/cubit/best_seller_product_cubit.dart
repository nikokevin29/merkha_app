import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'best_seller_product_state.dart';

class BestSellerProductCubit extends Cubit<BestSellerProductState> {
  BestSellerProductCubit() : super(BestSellerProductInitial());

  Future<void> showProductbyBestSeller({String limit}) async {
    ApiReturnValue<List<Product>> result =
        await ProductServices.showProductbyBestSeller(limit: limit);
    if (result.value != null) {
      emit(BestSellerProductListLoaded(result.value));
      print('Best Seller Loaded');
    } else {
      emit(BestSellerProductLoadingFailed(result.message));
    }
  }
}
