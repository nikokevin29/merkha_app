import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'feedbestseller_state.dart';

class FeedbestsellerCubit extends Cubit<FeedbestsellerState> {
  FeedbestsellerCubit() : super(FeedbestsellerInitial());
  Future<void> showFeedByBestSeller({String limit}) async {
    ApiReturnValue<List<Feed>> result = await FeedServices.showFeedByBestSeller(limit: limit);
    if (result.value != null) {
      emit(FeedByBestSellerListLoaded(result.value));
    } else {
      emit(FeedByBestSellerFailed(result.message));
    }
  }
}
