import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'feedbymerchantid_state.dart';

class FeedbymerchantidCubit extends Cubit<FeedbymerchantidState> {
  FeedbymerchantidCubit() : super(FeedbymerchantidInitial());

  Future<void> showFeedByMerchantId({String id}) async {
    ApiReturnValue<List<Feed>> result = await FeedServices.showFeedByMerchantId(id: id);
    if (result.value != null) {
      emit(FeedByIdMerchantListLoaded(result.value));
    } else {
      emit(FeedByMerchantIdFailed(result.message));
    }
  }
}
