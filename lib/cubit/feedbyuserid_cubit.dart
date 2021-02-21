import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'feedbyuserid_state.dart';

class FeedbyuseridCubit extends Cubit<FeedbyuseridState> {
  FeedbyuseridCubit() : super(FeedbyuseridInitial());
  Future<void> showFeedByUserId({String id}) async {
    ApiReturnValue<List<Feed>> result = await FeedServices.showFeedByUserId(id: id);
    if (result.value != null) {
      emit(FeedByUserIdListLoaded(result.value));
    } else {
      emit(FeedByUserIdFailed(result.message));
    }
  }
}
