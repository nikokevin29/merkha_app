import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'feedbymerchantcategory_state.dart';

class FeedbymerchantcategoryCubit extends Cubit<FeedbymerchantcategoryState> {
  FeedbymerchantcategoryCubit() : super(FeedbymerchantcategoryInitial());
  Future<void> showFeedByMerchantCat({String id}) async {
    ApiReturnValue<List<Feed>> result = await FeedServices.showFeedByMerchantCategory(id: id);
    if (result.value != null) {
      emit(FeedByMerchantCatListLoaded(result.value));
    } else {
      print(result.message);
      emit(FeedByMerchantCatFailed(result.message));
    }
  }
}
