import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'ownfeed_state.dart';

class OwnfeedCubit extends Cubit<OwnfeedState> {
  OwnfeedCubit() : super(OwnfeedInitial());
  Future<void> showOwnFeed() async {
    ApiReturnValue<List<Feed>> result = await FeedServices.showOwnFeed();
    if (result.value != null) {
      emit(OwnFeedListLoaded(result.value));
    } else {
      emit(OwnFeedFailed(result.message));
    }
  }
}
