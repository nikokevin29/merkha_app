import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  FollowCubit() : super(FollowInitial());

  Future<void> follow({String id}) async {
    ApiReturnValue<Following> result = await FollowingService.follow(id: id);
    if (result.value != null) {
      print(result.value);
      emit(FollowLoaded(result.value));
    } else {
      emit(FollowFailed(result.message));
    }
  }

  Future<void> unfollow({String id}) async {
    ApiReturnValue<Following> result = await FollowingService.unfollow(id: id);
    if (result.value != null) {
      emit(FollowLoaded(result.value));
    } else {
      emit(FollowFailed(result.message));
    }
  }

  Future<void> checkstatus({String id}) async {
    var result = await FollowingService.checkstatus(id: id);
    if (result.value != null) {
      print(result.value.following.toString());
      emit(FollowCheck(result.value.following.toString()));
    }
     else {
      emit(FollowFailed(result.message));
    }
  }

  Future<void> followList() async {
    ApiReturnValue<List<Following>> result = await FollowingService.followList();
    if (result.value != null) {
      emit(FollowListLoaded(result.value));
    } else {
      emit(FollowFailed(result.message));
    }
  }
}
