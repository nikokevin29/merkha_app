import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'product_by_category_state.dart';

class ProductByCategoryCubit extends Cubit<ProductByCategoryState> {
  ProductByCategoryCubit() : super(ProductByCategoryInitial());

  Future<void> showProductByCategory({String categoryId}) async {
    ApiReturnValue<List<Product>> result =
        await ProductServices.showProductByCategory(categoryId: categoryId);
    if (result.value != null) {
      emit(ProductByCategoryListLoaded(result.value));
    } else {
      emit(ProductByCategoryLoadingFailed(result.message));
    }
  }
}
