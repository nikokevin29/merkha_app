import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'review_merchant_state.dart';

class ReviewMerchantCubit extends Cubit<ReviewMerchantState> {
  ReviewMerchantCubit() : super(ReviewMerchantInitial());

  Future<void> showReviewMerchant({String merchantId}) async {
    ApiReturnValue<List<ReviewMerchant>> result =
        await ReviewServices.showReviewMerchant(merchantId: merchantId);
    if (result.value != null) {
      emit(ReviewMerchantLoaded(result.value));
    } else {
      emit(ReviwMerchantLoadingFailed(result.message));
    }
  }
}
