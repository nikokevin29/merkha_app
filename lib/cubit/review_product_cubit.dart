import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'review_product_state.dart';

class ReviewProductCubit extends Cubit<ReviewProductState> {
  ReviewProductCubit() : super(ReviewProductInitial());

  Future<void> showReviewProduct({String productId}) async {
    ApiReturnValue<List<ReviewProduct>> result =
        await ReviewServices.showReviewProduct(productId: productId);
    if (result.value != null) {
      emit(ReviewProductLoaded(result.value));
    } else {
      emit(ReviwProductLoadingFailed(result.message));
    }
  }
}
