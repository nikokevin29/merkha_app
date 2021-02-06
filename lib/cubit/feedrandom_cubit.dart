import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'feedrandom_state.dart';

class FeedrandomCubit extends Cubit<FeedrandomState> {
  FeedrandomCubit() : super(FeedrandomInitial());
  Future<void> showFeedRandom({String limit}) async {
    ApiReturnValue<List<Feed>> result = await FeedServices.showFeedRandom(limit: limit);
    if (result.value != null) {
      emit(FeedRandomListLoaded(result.value));
      print('Feed Ranom By Limit Loaded');
    } else {
      emit(FeedRandomFailed(result.message));
    }
  }
}
